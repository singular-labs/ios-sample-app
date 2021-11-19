# Singular's iOS SDK Sample App

## Overview
This app demonstrates Singular's best practices for implementing the iOS SDK.

This sample contains examples of:

- Requesting App Tracking Transparency
- Initializing the Singular SDK
- Setting Singular configuration options
- Enabling SkAdNetwork and Conversion Value management
- Setting Data Privacy option for GDPR or CCPA compliance
- Setting custom user id
- Sending custom events
- Sending revenue events
- Handling deep links / deferred deep links and passthroughs
- Enable ESP Tracking Domain

## Getting Started
To run the sample app you'll have to configure your own API Key / Secret as follows:

1. Retrieve the API Key & Secret from your account's SDK Keys page, here: https://app.singular.net/?#/sdk
2. Open the ios-sample-app project in XCode
3. Go to the Constants.h file and replace the values of `APIKEY` & `SECRET` with your credentials
