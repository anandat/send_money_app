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

<img width="352" height="760" alt="Screenshot 2025-07-13 at 12 51 16 PM" src="https://github.com/user-attachments/assets/d8bf8dec-a64d-4fce-b24b-026ba9de4549" />
<img width="346" height="749" alt="Screenshot 2025-07-13 at 12 51 26 PM" src="https://github.com/user-attachments/assets/a7619373-2b29-443c-bd1c-b27090c5d434" />
<img width="344" height="761" alt="Screenshot 2025-07-13 at 12 51 34 PM" src="https://github.com/user-attachments/assets/f194c10a-77fa-46f9-a113-f9aa40721cf2" />
<img width="371" height="809" alt="Screenshot 2025-07-13 at 12 51 48 PM" src="https://github.com/user-attachments/assets/15cfaa8c-9a45-4e55-bab2-8ef9e3590837" />


