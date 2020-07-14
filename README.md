
# Atrium Demo App


A web app that consumes the Atrium API from MX to allow users to pull in multiple accounts from multiple financial instutitions so they can easily view all of their balances and transactions in one place.

This app is a very basic demo of the Atrium API.


# Setup to run locally

1. Clone the repo. `git clone https://github.com/mxenabled/atrium-demo.git`
2. Go into the project directory. `cd atrium-demo`
3. Install rails dependencies. `bundle install`
4. Run `yarn install —check-files`
5. Set up the database `rails db:setup`
6. Start up the local server `rails s`

The above steps will get the app up an running with default page routes for `sign up`, `login` and `forgot password`. We are using the Devise gem for authentication. If you forget to do this you will get errors when you try to sign up a user. Once you add your credentials and create an account you will be able to see pages for aggregating accounts and managing your user profile.

In order to start pushing/pulling data from the MX API you will need to add your Atrium API credentials to the `credentials.yml.enc file`.

To do this you will run the command `EDITOR=vim rails credentials:edit` in your terminal. This should generate both the `credentials.ymc.enc` file as well as a `master_key` file. Once inside the credentials file you will need to add your `MX-API-Key` and your `MX-Client-ID` as seen below. You can find your api keys on the `API keys and whitelisting` page in the Atrium portal when you are logged in. https://atrium.mx/security

```
mx_api_key: {your key here}
mx_client_id: {your id here}
```
Once you save the file and you should be able to hit the Atrium API on the app. You can sign up a user and it will log you in where you can see your user profile page and aggregate accounts. This documentation page has credentials to allow you to test different aggregation possibilites using `MX Bank`. https://atrium.mx.com/docs/getting_started#testing-your-setup
