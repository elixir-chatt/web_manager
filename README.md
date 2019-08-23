# To start the app
`docker-compose up`

# Postgres through docker

`docker run --name some-postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=web_manager_dev -p 5432:5432 -d postgres`

Add the right api keys and secret to the `config.exs`

## Digital Ocean S3

`ExAws.Config.new(:s3)` this will show the current configuration in the config file

`ExAws.S3.list_objects("photobooth") |> ExAws.request()` will test the connection with the specified bucket ("photobooth")

```
"/Users/hexpl0it/Downloads/elm.png" \
|> ExAws.S3.Upload.stream_file \
|> ExAws.S3.upload("photobooth", "path/sss.png") \
|> ExAws.request
```
