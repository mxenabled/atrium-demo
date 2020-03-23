
# Atrium Demo App


A web app that consumes the Atrium API from MX to allow users to pull in multiple accounts from multiple financial instutitions so they can easily view all of their balances and transactions in one place.

This app will serve as a very basic demo of the Atrium API. 


# Setup to run locally

You will need to add your Atrium API credentials to the credentials.yml.enc file. To do this you will run the command `EDITOR=vim rails credentials:edit` in your terminal. This should generate both the credentials.ymc.enc file as well as the master_key. Once inside the credentials file you will need to add your `MX-API-Key` as `mx_api_key: {your key here}` and your `MX-Client-ID` as `mx_client_id: {your id here}`. Save the file and you should be able to hit the Atrium API on the app. 
