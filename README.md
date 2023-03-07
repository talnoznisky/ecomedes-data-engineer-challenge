# Steps to Complete

1. Learn the schema by examining the `migrations` directory or by
   interacting w/the database.
2. Write the appropriate query in each `queries/query-*.sql` file.
3. Write a python script that will:
   - output each query to a CSV file
   - create a zip archive containing the CSV files
   - email the archive to a recipient whose address was provided via
     the command line

# Running the container

```shell
./scripts/run.sh
```

This will start a psql instance running on `localhost` at port `9999`
with username `postgres` and password `foo`.

If you want a different port you can specify the port number as the
first parameter:

```shell
./scripts/run.sh 9999
```

If you want a different password you can specify that with the second
paramter:

```shell
./scripts/run.sh 9999 foo
```

# Connecting to the container

Once the container is running, you can connect to it using any
postgres database tool you like. For example, assuming you've used the
default parameters, you can use the `psql` cli command like so:

```shell
psql postgres://postgres:foo@localhost:9999
```
