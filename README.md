# StockManager

StockManager is a Ruby on Rails Web App / API and an Ionic 2 Hybrid app. 

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


Clinics, Products and Users are managed from the controllers


#### Business rules


* Minimum stock quanity of product is attribute of product

* Clinic address is mandatory and a reverse geocoding is done to get latitude and longitude of clinic

* Stock get automaticaly created when product or clinic is added and minimum order is set on all stock

* Minimun order of each stock item is attribute of stock

* StockTake gets created via API from app

* When stock reaches minimum order a SMS gets send to a mobile number that is an attribute of the clinic


#### App business rules


* User needs to exists on system

* User login with mobile and receive sms code to login

* User location is accessed and the nearest clinic is displayed

* User scans product with barcode scanner to identify stock and enter quantity

* User can swipe left to set zero quantuty when product is out of stock an is unable to scan


### How to use the App

The app can be used via the Ionic View App : <http://view.ionic.io/>


Register or login and preview the app using the following code:

0656f90a



