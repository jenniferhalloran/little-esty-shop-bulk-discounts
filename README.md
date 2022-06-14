# Little Esty Shop Bulk Discounts 

![languages](https://img.shields.io/github/languages/top/jenniferhalloran/little-esty-shop-bulk-discounts?color=red)
![PRs](https://img.shields.io/github/issues-pr-closed/jenniferhalloran/little-esty-shop-bulk-discounts)
![rspec](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![simplecov](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov) <!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/contributors-1-orange.svg?style=flat)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

## Background and Description

This project is an extension of the Little Esty Shop group project. You will add functionality for merchants to create bulk discounts for their items. A “bulk discount” is a discount based on the quantity of items the customer is buying, for example “20% off orders of 10 or more items”.
- Original Project and Requirements for Little Esty Shop can be found [here](https://github.com/turingschool-examples/little-esty-shop).
- The Project and Requirement for Bulk Discount can be found [here](https://backend.turing.edu/module2/projects/bulk_discounts).

## Learning Goals
- Write migrations to create tables and relationships between tables
- Implement CRUD functionality for a resource using forms (form_tag or form_with), buttons, and links
- Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
- Use built-in ActiveRecord methods to join multiple tables of data, make calculations, and group data based on one or more attributes
- Write model tests that fully cover the data logic of the application
- Write feature tests that fully cover the functionality of the application
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code
## Phases



## Database Diagram
![Bulk_Discounts_Diagram](https://user-images.githubusercontent.com/48455658/173657381-fc8a65c6-9f04-47e2-b501-16f61ebcee54.png)

## Requirements and Setup (for Mac):

### Ruby and Rails
- Ruby Version 2.7.2
- Rails Version 5.2.6

### Gems Utilized
- RSpec 
- Pry
- SimpleCov
- Capybara
- Launchy
- Shoulda-Matchers v5.0
- Orderly 
- Factory_Bot_Rails
- HTTParty
- JSON
- WebMock
- VCR

## Setup
1. Clone this repository:
On your local machine open a terminal session and enter the following commands for SSH or HTTPS to clone the repositiory.


- using ssh key <br>
```shell
$ git clone git@github.com:jenniferhalloran/little-esty-shop-bulk-discounts.git
```

- using https <br>
```shell
$ git clone https://github.com/jenniferhalloran/little-esty-shop-bulk-discounts.git
```

Once cloned, you'll have a new local copy in the directory you ran the clone command in.

2. Change to the project directory:<br>
In terminal, use `$cd` to navigate to the Little Esty Shop Bulk Discounts project directory.

```shell
$ cd little-esty-shop-bulk-discounts
```

3. Install required Gems utilizing Bundler: <br>
In terminal, use Bundler to install any missing Gems. If Bundler is not installed, first run the following command.

```shell
$ gem install bundler
```

If Bundler is already installed or after it has been installed, run the following command.

```shell
$ bundle install
```

There should be be text diplayed of the installation process that looks similar to below.

```shell
$ bundle install
Fetching gem metadata from https://rubygems.org/........
Resolving dependencies...
Using bundler 2.1.4
Using byebug 11.1.3
Fetching coderay 1.1.2
Installing coderay 1.1.2
Using diff-lcs 1.4.4
Using method_source 1.0.0
Using pry 0.13.1
Fetching pry-byebug 3.9.0
Installing pry-byebug 3.9.0
Fetching rspec-support 3.10.1
Installing rspec-support 3.10.1
Fetching rspec-core 3.10.1
Installing rspec-core 3.10.1
Fetching rspec-expectations 3.10.1
Installing rspec-expectations 3.10.1
Fetching rspec-mocks 3.10.1
Installing rspec-mocks 3.10.1
Fetching rspec 3.10.0
Installing rspec 3.10.0
Bundle complete! 3 Gemfile dependencies, 12 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```
If there are any errors, verify that bundler, Rails, and your ruby environment are correctly setup.

4. Database Migration
Before using the web application you will need to setup your databases locally by running the following command

```shell
$ rails db:{:drop,:create,:migrate,:seed}
```

5. CSV Load
Next we will seed environment with generic data by using CSV files by running the following command

```shell
$ rake csv_load:create 
```

6. Startup and Access<br>
Finally, in order to use the web app you will have to start the server locally and access the app through a web browser. 
- Start server
```shell
$ rails s
```

- Open web browser and visit link
    http://localhost:3000/
    
At this point you should be taken to the welcome page of the web-app. If you encounter any errors or have not reached the web-app please confirm you followed the steps above and that your environment is properly set up.

## Heroku Deployment
- The deployment to Heroku can be found [here](https://little-esty-shop-discounts.herokuapp.com/)
<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
<!--
