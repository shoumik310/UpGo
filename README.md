# IOT Project App - UpGo

This app is a companion to our fall detector. It uses a MPU 6050 attached to a NODEMCU to detect when a person has fallen and uses Firebase Cloud Messaging to push a notification the app. The app locally stores all data which one would require if they had to go to a hospital. The App has authentication using Firebase to ensure that sensitive details are not accessed by unauthorised persons.

This repository contains 3 branches
master- Contains flutter code for the android application
Cloud_Function - Cloud function that is the backend for Firebase to send the notification on update of parameter
NodeMcu_code - .ino file containing code for the nodemcu
