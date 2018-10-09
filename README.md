# :tada: Mpesa-stk Rails example :tada:

## Why
A lot of guys were giving us feedback that [mpesa-stk gem](https://github.com/mboya/mpesa_stk) is not working.  
Without the specifics of what exactly failed during  integration with a Rails or Sinatra application, it is difficult to offer help.  
We therefore saw it necessary to build a sample application to show folks that it works and have an app that one can follow/fork and reuse :smiley:  
This will hopefully also facilitate specific/more detailed enquiries :stuck_out_tongue_winking_eye:

**This is a simple Rails app with the mpesa stk integrated.**  

- You can test it [here](https://stkpush.herokuapp.com/)
- Just enter an amount(minimum of Ksh.5), and your phone number.
- You will be prompted to enter your m-pesa pin number on your phone.
- Do not worry this is just an M-pesa sandbox transaction and your money will be refunded back to your m-pesa account by midnight :punch:

## Installations
If you want to reuse or contribute, fork the repo and clone locally.  
Then run,  
`$ bundle install`  
`$ rake db:create db:migrate`  
If you encounter an error `NoDatabaseError` while setting up the database add `username: postgres` in `config/database.yml`  
You need a `.env` file for the requests to work locally.  
Essentials in the .env file  
```
.env

base_url="https://sandbox.safaricom.co.ke"
token_generator_url=
process_request_url=

key=
secret=
business_short_code=
business_passkey=
callback_url="ngrok_url/callback"
```
You can generate `key` and `secret` in your  [daraja dev account](https://developer.safaricom.co.ke/user/me/apps)  
`business_short_code` and `business_passkey` can be found in the [Test Credentials](https://developer.safaricom.co.ke/test_credentials)  
As for `callback_url` fire up ngrok using  `$ ./ngrok http 3000` or a tunnelling tool of your choice and use the url.  
Make sure the port ngrok is using is the same as the one the rails app is running on.  
You will need redis to be running since the gem has a redis dependency. You can configure it to start when launching the app or  run `sudo service redis start`

**_If you have any queries or complaints open an issue_**

Happy Hacking :v:
