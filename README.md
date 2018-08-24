# Customer Records
CLI application to import text file each line in json format and return the close customers from a certain point within a certain distance
# Architecture
  - Data Stores: Implementations for Different Data stores logic (initially it contains In memory) and can be expanded easily to include another data stores like redis
  - Entites: Implementation for business objects
  - Presenters: Implementation for presentation logic for each business objects
  - services:
    - Geodesy: include geodesy services [degree to radian converter, distance calulator]
    - Importer: include interface for generic importer implementation, and user importer a smple of importer implementation for importing users besides the custom validation and custom exceptions for user importing logic
  - Use cases: include logic to run each use case [import users, and retrieve close users]
  - Runners: in considered as a controller where each can cascade one or more use cases

The idea is to separate the business logic away from impelmentation details(CLI, Data store) for easy expansion and design flexability, so simply that app can wrap Web interface or a new data store (like postgres) can be added without changing without touching the business logic

#Usage
```sh
Usage: run.rb [options]
  -h, --help                       Print this help
  -f, --file FILE                  relative file path include customers data (default ./customers.txt)
  -d, --distance DISTANCE          max aloowed distance from the origin (default 100)
  -o, --origin ORIGIN              origin point 2 numbers seperated by , (default 53.339428, -6.257664)
```
# Run
To Run the app locally
```sh
$ bundle install
$ ruby ./run.rb
```

# Run Tests (100% Test coverage)
To run the app tests
```sh
$ rspec
```
