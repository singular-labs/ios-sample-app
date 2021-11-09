# Singular's iOS SDK Sample App

## Overview
This app demonstrates Singular's best practices for implementing the iOS SDK.

This sample contains examples of:

- Initializing the Singular Config Object
- Setting Config Options
- Setting custom user id
- Sending custom events
- Sending revenue events
- Handling deep links / deferred deep links & passthroughs
- Support ESP Domain
- Supporting Global Properties

## Getting Started
To run the sample app you'll have to configure your own API Key / Secret as follows:

1. Retrieve the API Key & Secret from your account's SDK Keys page
2. Open the ios-sample-app project in XCode
3. Go to the Constants.h file and replace the values of `APIKEY` & `SECRET` with your credentials
4. Update your Associated Domain capabilitiy per: https://support.singular.net/hc/en-us/articles/360031371451-Singular-Links-Prerequisites?navigation_side_bar=true
5. Update your URL scheme in the Target App > Info > URL Types
6. Update the bundle identifier in the Target App > General tab to something unqiue
7. Add the Push Notification capability per: https://support.singular.net/hc/en-us/articles/360000269811-Uninstall-Tracking-APNS-Apple-Push-Notification-Service
