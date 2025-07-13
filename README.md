# Send Money App

A Flutter application demonstrating:
- Clean Architecture
- BLoC State Management (no Cubit)
- Dio with Logging Interceptor
- Unit and Widget Testing
- Mock API integration

---

## Features
##
- Username: user
- Password: 1234
##
- Login / Logout  
  Simple username/password authentication

- Wallet Balance  
  Toggle show/hide balance visibility

- Send Money  
  Sends a fake POST request to simulate money transfer

- Transaction History  
  Fetched from a mock GET API (user list used for demonstration)

- BLoC-based logic throughout (no Cubit used)

- Dio HTTP client with custom logging interceptor

---


This project includes both **widget tests** and **BLoC unit tests**:


flutter test

---


Getting Started
Follow these steps to run the app locally:

- cd send_money_app
- flutter pub get
- flutter run

## API Details

Send Money (POST):
This uses a fake to simulate a money transfer.

Transaction History (GET):
Since the fake API does not return actual transactions, a mock list of users is used to simulate a transaction history view.



flutter_bloc – for state management

dio – for HTTP requests

bloc_test – for BLoC testing

## ScreenShots 
![Screenshot 2025-07-13 at 12.51.48 PM.png](..%2F..%2FDesktop%2FScreenshot%202025-07-13%20at%2012.51.48%E2%80%AFPM.png)

![Screenshot 2025-07-13 at 12.51.48 PM.png](..%2F..%2FDesktop%2FScreenshot%202025-07-13%20at%2012.51.48%E2%80%AFPM.png)

![Screenshot 2025-07-13 at 12.51.26 PM.png](..%2F..%2FDesktop%2FScreenshot%202025-07-13%20at%2012.51.26%E2%80%AFPM.png)

![Screenshot 2025-07-13 at 12.51.16 PM.png](..%2F..%2FDesktop%2FScreenshot%202025-07-13%20at%2012.51.16%E2%80%AFPM.png)

![Screenshot 2025-07-13 at 12.51.09 PM.png](..%2F..%2FDesktop%2FScreenshot%202025-07-13%20at%2012.51.09%E2%80%AFPM.png)
