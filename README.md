# StockManager

StockManager was created with a Ruby on Rails Web App and an Ionic 2 Hybrid app. The Rails app serves as the backend for the app aswell 
as a restfull API for the App.

The web app is hosted on Heroku and is located at: <https://mezzanine-stock.herokuapp.com>

### Database Model (Tables)



* Product

* Clinic

* Stock

* StockTake

* User


CRUD action is performed by the controller (app/controllers)

All business logic is inside the models (app/models)

API controller to serve the app(app/controllers)


### Basic Business rules


Clinics, Products and User is manages via controllers

#### Business rules

* Minimum stock quanity of product is attribute of product

* Clinic address is mandatory and a reverse geocoding is done to get latitude and longitude of clinic

* Stock get automaticaly created when product or clinic is added and minimum order is set on all stock

* Minimun order of each stock item is attribute of stock

* StockTake gets created via API from app

* When stock reaches minimum order a SMS gets send to a mobile number that is an attribute of the clinic


