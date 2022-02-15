# Flutter & Firebase Shopping App

A shopping mobile app which is made with Flutter and Firebase technologies.

## Screenshots

|                                               |                                               |                                               |
|-----------------------------------------------|-----------------------------------------------|-----------------------------------------------|
| <img width="100%" src="./Screenshots/0.png"> | <img width="100%" src="./Screenshots/1.png"> | <img width="100%" src="./Screenshots/2.png"> |
| <img width="100%" src="./Screenshots/3.png"> | <img width="100%" src="./Screenshots/4.png"> | <img width="100%" src="./Screenshots/5.png"> |
| <img width="100%" src="./Screenshots/6.png"> | <img width="100%" src="./Screenshots/7.png"> | <img width="100%" src="./Screenshots/8.png"> |
| <img width="100%" src="./Screenshots/9.png"> |  |  

## Firebase (Firestore) Structure

- **Users** (Collection)
	- email (String)
	- name (String)
	- surname (String)
	- phoneNumber (String)
- **Vendors** (Collection)
	- city (String)
	- contact (String)
	- email (String)
	- name (String)
- **Brands** (Collection)
	- name (String)
	- website (String)
- **Cards** (Collection)
	- name (String)
- **Products** (Collection)
	- **Assessments** (Collection)
		- assessmentId (String)
		- score (Number)
		- userReference (Reference)
	- brandReference (Reference)
	- categoryIds (Array)
	- features (Map)
	- name (String)
	- vendors (Array)
		- cartDiscount (Number)
		- discount (Number)
		- price (Number)
		- vendorReference (Reference)
		- paymentOptions (Array)
			- cardReference (Reference)
			- installments (Array)
				- amount (Number)
				- month (Number)

## Admin Panel
[Flutter Firebase Shopping App Admin Panel](https://github.com/canersulusoglu/firebase-shopping-app-admin-panel) repository.

## Flutter and Dart Versions

[Flutter](https://flutter.dev/) 2.5.0 or greater

[Dart](https://dart.dev/) between 2.14.0 or greater and less 3.0.0