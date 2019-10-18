# Devise: Setup and customization

Set up a Rails server with [Devise] to let users log in with a username and
password.

## Objectives

We're going to use Devise and Rails to create an app with a complete sign-in
flow. For the most part, we will be able to do this using only generators. This
is one of the compelling reasons people use Rails: it's a universe full of
solved problems that can be rapidly deployed.

## Instructions: Part 1, Setup

Add Devise to your `Gemfile`:

    gem 'devise'

Now run the installer:

    rails generate devise:install

This comes purely from the [Devise] documentation. We're just following
instructions.

This creates a massive initializer in `config/initializers/devise.rb`.

You'll notice that the installer prints a big notice of several things you
should do. In particular, we should have a root route.

Create a `WelcomeController` with a `home` action and a view that just prints
`current_user.email`.

Now generate your `User` model with:

    rails g devise User

Run `rake routes` and `rake db:migrate`. You should see that Devise has added a
bunch of them. Run `rails s` and take a look at one, maybe `/users/sign_in`.

You should now have a working app with sign in.

## Part 2, Customization

Now let's add Facebook login support with [Omniauth].

Add the `omniauth-facebook` gem to your Gemfile:

    gem 'omniauth-facebook'

As you might intuit, since we're going to allow users, modeled by the `User`
class to log in with another authentication system, we need to store some more
data about those users in our `users` table in _our_ database. This means we
need to write a migration.

We'll need to store two more columns in our user model: a `provider` `String`
(which will always be `'facebook'` or `nil` in our app for the moment; you
might imagine `'google'` or `'github'` might be other options), and a `uid`,
the user's authenticated Facebook ID.

```shell
rails g migration AddOmniauthToUsers provider:index uid:index
rake db:migrate
```

### Configuring Omniauth for Facebook Use

And add the [Omniauth] configuration to `config/initializers/devise.rb`:

    config.omniauth :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']

What's actually happening here is we're invoking a method:

    config.omniauth(:facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'])

The parameters for the method are something like:

    config.omniauth(third-party-authentiation, login, password)

So what we're telling [Omniauth] is how to log _our application_ in.

To confuse things further, instead of just passing in an actual login like
`"example-key"` or a passworld like `"super-secret-p@ssW()rD!' to
`config.omniauth`, we're passing in references to keys from a hash called
`ENV`. What's going on with this?

As you might recall from learning about the command-line environment, there are
a number of variables that can be set in the shell. When those variables are
set, programs launched from within the shell inherit those variables.  We use
the shell command `export` to define a variable in a shell. When a program is
run from that shell, particularly `rails`, it takes those environment variables
and puts them in  globally-accessible `Hash` called `ENV`.

> ***IMPORTANT**: Keep in mind, your Rails server ***must be run from a shell
> with set ENV variables***. Use the command `env` to see what your environment
> variables are.  If you don't see the environment variables you expect, Rails
> won't see them either.

So all this explanation and code comes down to this: We write important data to
unix environment variables and we pass those variables' special information to
`config.omniauth`.

This might sound confusing, but the alternative would be to store our login key
and our login password within `config/initializers/devise.rb`. If we did that,
when we pushed our code to GitHub, **anyone in the world could harvest our
identity**. In fact, research shows that there are bots crawling GitHub
***right now*** searching for people having made these mistakes.

## Getting a `FACEBOOK_KEY` and `FACEBOOK_SECRET` 

To set things up with `config.omniauth`, we need to get those values.

_Keep in mind, the Facebook UI may change subtly over time._

Create an application in the [Facebook developer console][fbdev] and get these
values from there. You'll also need to go to +Add Product in the sidebar menu
on the left. This will bring you to the Product Setup page. Here click 'get
started' for Facebook Login and set Valid OAuth Redirect URLs that point to
your application.

We might expect that we could provide URLs like:

`http://<YOUR_SERVER_ADDRESS>/users/auth/facebook/callback`

Which would typically be exemplified by:

`http://localhost:3000/users/auth/facebook/callback`

However, since March of 2018, Facebook now requires us to provide ***https**
URLs. Rails does not, by default, start up an https-capable server. To get
around this, start up the Rails server with `thin start --ssl` **instead of**
`rails s` or `rails server`. We're sorry to toss this extra complexity in, but
the continued war between those who seek to compromise web applications and
those who build them necessitates this. Note: your browser, (Chrome, for
instance), may display a security warning that you are not accessing a secure
site (in the end we are just faking an https url to satisfy Facebook). Feel
free to bypass that warning and continue on to your site.

This setting is listed under `Client OAuth Settings` in the dashboard.

Confusingly, `FACEBOOK_KEY` is called appId in their console. Set the values in
your shell in which you run `rails` like so:

    export FACEBOOK_KEY=your_app_id
    export FACEBOOK_SECRET=your_app_secret

To make these changes permanent, we can either update our command-line setup
code (our `~/.bashrc`) or we can make use of the [dotenv] gem. We'll not cover
those here, but dotenv stores these variables in a file (`.env`) that Rails
automatically reads on startup.

Add this line to your `user.rb` to enable omniauth:

    devise :omniauthable, :omniauth_providers => [:facebook]

And add this line to your welcome view:

     <%= link_to "Sign in with Facebook", user_facebook_omniauth_authorize_path %>

If you visit the welcome page and click "Sign in with Facebook," you should be
able to go through a Facebook application authorization flow.

When you return to your app, you'll be greeted with an error: `The action
'facebook' could not be found for Devise::OmniauthCallbacksController`. Okay,
let's make one.

Add this to `routes.rb` to create a route for Omniauth to send its
authentication data to:

    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

Now add a file `app/controllers/users/omniauth_callbacks_controller.rb`:

    class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
      def facebook
        # TODO
      end
    end

The action should have the same name as the provider. In this case, Facebook.

Now we have to write some code to handle the code [Omniauth] got back from
Facebook.

    def facebook
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user      
    end

We have to write the `User.from_omniauth` method ourselves.

    class User < ActiveRecord::Base
      def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.email = auth.info.email
          user.password = Devise.friendly_token[0,20]
        end      
      end
    end

Here we look for a user with that (`provider: :facebook, uid: your_uid`) pair
and create them if they aren't in the database. For Facebook users, we create a
random password. The expectation is that users logging in with Facebook don't
subsequently want to set a password.

You should now see a missing template error. But wait, didn't we say `sign_in_and_redirect`? Where are we being redirected to?

It turns out that Devise doesn't know automatically. We have to write a method in our `ApplicationController`:

    def after_sign_in_path_for(resource)
      request.env['omniauth.origin'] || root_path
    end
    
## Part 3, Displaying Errors

We have a basic sign up/in/out flow setup with Facebook login! Start the server
with `rails s` to try it out. There is just one problem though. When a visitor
has an incorrect login attempt, no feedback is given! Since creating custom
views for each view is a bit of a pain (feel free to try it from the docs
[here][custom-layouts]) we are simply going to use a simple hack.

Devise adds all the messages it wants to display in the `flash` hash that is
available to our views. Since we do not have any intense CSS going on we can
simply add the following code to our `application/application.html.erb` file

```erb
<%- flash.each do |name, msg| -%>
  <%= content_tag :div, msg, :id => "flash_#{name}" if msg.is_a?(String) %>
<%- end -%>
```

This will display _all_ flash messages at the top of each page. This allows us
to present failure information to the user without overriding the Devise
templates. For more full implementations we'd build a series of custom views,
but for the purpose of understanding [Omniauth]'s third-party sign-up
capabilities, it's sufficient.

If you **do** want to go so far as to take over the management of the [Devise]
views, you need to get [Devise] to put them "into" your Rails application so
that you have files to edit. To do this you're going to need to use [Devise]'s
`devise:views` generator. The [documentation][Devise] describes this workflow.

## Lab Spec Notes

1. To pass all the tests you will need to create a `/about` route, view and
   controller (under `WelcomeController`) to display a simple about page.
2. Passwords must be 6 characters or longer (you can achieve this with a length
   validation on `:password` in the `User` model with devise)

## Hiccups

If Devise doesn't seem able to get an email from Facebook, you may have to
de-authorize and re-authorize your application in your Facebook privacy
settings.

[Devise]: https://github.com/plataformatec/devise
[fbdev]: https://developer.facebook.com
[custom-layouts]: https://github.com/plataformatec/devise/wiki/How-To:-Create-custom-layouts
[Omniauth]: https://github.com/omniauth/omniauth

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/devise_lab'>Devise Lab</a> on Learn.co and start learning to code for free.</p>
