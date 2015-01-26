# Noti

This is the Ruby library which allows you to send notifications to your
user's desktops using the [Noti](http://notiapp.com) service.

Once a user has the application installed on their computer, you are able
to send notifications straight to their desktop without any need for them
to be running your web app.

## Installing

Just add the gem to your Gemfile and follow the instructions on this page.

```
gem 'noti'
```

## Configuring

In order to communicate with the service, you will need to create your own
Noti account and create an application. Once the application has been created
you should set the application key as shown (replacing the key shown with
the key you are provided with when you create your app):

```ruby
Noti.app = '7f38ce2d-8d9a-25dd-e167-8f8a711b81f8'
```

## Authenticating Users

Before you can send notifications to your users, they need to authorise your
application. This is an easy process which is initiated from your application.

#### Step 1 - Creating a request token

To begin, you will need to create a request token. You can do this using the `Noti.create_request_token`
command. This command accepts the URL to redirect to the to once they have
authorised your application.

```ruby
token = Noti::Token.create_request_token("http://myapp.com/noti/callback")
```

You will receive back a `Noti::Token` instance which has responds to the following
methods:

```ruby
token.request_token   #=> '8494c9ed-6ca4-1af1-40ce-21954140d204'
token.redirect_url    #=> 'http://notiapp.com/auth/8494c9ed-6ca4-1af1-40ce-21954140d204'
```

You should store the `request_token` and redirect your user to the URL provided in the
`redirect_url`. Once at this page the user will be prompted to enter their Noti credentials or create an account.

#### Step 2 - Obtaining an access token

Once the user has authorised and been returned to the redirect URL you provide, you should
run the method below (passing the request token) to obtain an access token for this user.
This token should be stored and used whenever you wish to send a notification to this user.
This token will not expire unless the user revokes your application from being able to send
them notifications.

```ruby
access_token = Noti::Token.get_access_token('8494c9ed-6ca4-1af1-40ce-21954140d204')
```

The `access_token` variable will contain a string with the user's access token. Once you have
the access token you no longer need the request token.

## Sending a notification

In order to send a notification to a user, simply run the method shown below:

```ruby
# Create a new notification object
notification = Noti::Notification.new
notification.title = "An example notification"
notification.text = "Some further information about this notification"
notification.url = "http://myapp.com/example"
notification.sound = "alert1"
notification.image = "example"

# Set the user to send the notification to and deliver it
notification.deliver_to('a96dca45-bd18-63bc-2b19-2b3f5ce711ca')

# If you need to send the same notification to another user
notification.deliver_to('f1ed9821-0933-15d2-a4bc-b87f562424a0')
```

## Revoke an access token

To revoke an access token, simply run the method shown below:

```ruby
Noti::Token.revoke_access_token('a96dca45-bd18-63bc-2b19-2b3f5ce711ca')
```

