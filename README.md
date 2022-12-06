## Electro cars

Electro cars API app, read the documentation [here](https://www.postman.com/sardaratvertex/workspace/my-workspace/api/5ac890ca-dcd6-4c35-b967-951c5383c380)
# Requiremants
* Ruby version - 3.1.2p20
* Rails - 7.0.4
# Starting app locally

Clone repository

```bash
git clone with https://github.com/Torogeldiev-T/electro-cars.git
```

Install requirements

```bash
bundle install
```

Database setup

```bash
rails db:create
rails db:migrate
```

* Run seeds to initialize with database with data (development only) 

```bash
rails db:seed
```

# Run tests

```bash
bundle exec rspec
```
