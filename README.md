# Melp
This is an singles REST API tha was building using Phoenix framework. Here you can find some information to test it.

## Requirements
  * Install [PostGIS](https://postgis.net/) to install and setup dependencies
  * Run inside project folder:
  ```markdown
  mix ecto.create
  mix ecto.migrate
  ```
## Run
  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Fill database
Inside IEx:
```markdown
iex> Melp.CSVImport.import_csv("<file_path>")
```
## Test routes
Create:
* `POST: http://localhost:4000/api/restaurants, Body: Restaurant object`
Read:
* `GET: http://localhost:4000/api/restaurants/<id>`
Update:
* `PUT: http://localhost:4000/api/restaurants/<id>, Body: Restaurant object`
Delete:
* `DELETE: http://localhost:4000/api/restaurants/<id>`
Statistics:
* `GET: http://localhost:4000/api/statistics?latitude=<float>&longitude=<float>&radius=<float> Body: Restaurant object`