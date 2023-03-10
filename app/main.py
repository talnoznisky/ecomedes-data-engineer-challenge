from datetime import datetime
import os
import pathlib
import smtplib

from zipfile import ZipFile

from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication
from email.mime.text import MIMEText

import psycopg2
from psycopg2 import OperationalError


def connect_to_db():
    try:
        conn = psycopg2.connect(
            database='postgres',
            user='postgres',
            password='foo',
            host='localhost',
            port=9999,
        )
    except OperationalError as e:
        raise e

    return conn


def timestamp_to_string():
    """
    returns stringified now() timestamp for identifying file set
    """
    return datetime.now().strftime('%Y%m%d%H%M%S')


def get_queries_files(path:str='./queries'):
    """
    returns list of sql files in /queries/
    """
    return [os.path.join(path, file) for file in os.listdir(path)]


def create_target_dir():
    """"
    creates new directory ./data/{yyyymmddhhmmss}/
    """
    target_dir = f'./data/{timestamp_to_string()}'
    
    pathlib.Path(target_dir).mkdir(parents=True, exist_ok=True)

    return  target_dir
    

def create_outfile_path(target_dir: str, query_file: str, file_type: str='csv') -> str:
    query = query_file.split('/')[-1].split('.')[0]
    file_name = '_'.join([timestamp_to_string(), query])
    
    return f'{target_dir}/{file_name}.{file_type}'


def write_query_results(query_file, output_file):
    cur = connect_to_db().cursor()
    output_query = f"copy ({open(query_file, 'r').read()}) to stdout with csv header"

    with open(output_file, 'w') as f:
        cur.copy_expert(output_query, f)


def zip_files(target_dir):
    zip_file_name = f'{target_dir}/archive.zip'
    data_files = [os.path.join(target_dir, file) for file in os.listdir(target_dir)]
    
    with ZipFile(zip_file_name,'w') as zip:
        for data_file in data_files:
            zip.write(data_file)
    
    return zip_file_name

def email_zip_file(zip_file):
    smtp_server = "localhost"
    port = 1025 
    sender_email = "my@gmail.com"
    receiver_email = input('enter your email: ')

    msg = MIMEMultipart()
    body_part = MIMEText('The data your requested is attached', 'plain')
    msg['Subject'] = 'Data you requested'
    msg['From'] = sender_email
    msg['To'] = receiver_email
    msg.attach(body_part)

    with open(zip_file, 'rb') as file:
        msg.attach(MIMEApplication(file.read(), Name='archive.zip'))

    try:
        server = smtplib.SMTP(smtp_server, port)
        server.sendmail(sender_email, receiver_email, msg.as_string())
        print(msg.as_string())
    except Exception as e:
        print(e)

if __name__ == '__main__':
    target_dir = create_target_dir()
    query_files = get_queries_files()

    for query_file in query_files: 
        output_file = create_outfile_path(target_dir, query_file)
        write_query_results(query_file, output_file)

    zip_file = zip_files(target_dir)
    email_zip_file(zip_file)
