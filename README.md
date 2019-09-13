# Devise: Setup and customization

Set up a Rails server with [Devise] to let users log in with a username and password.

## Objectives

We're going to use Devise and Rails to create an app with a complete signin flow. We will basically be able to do this using only generators.

## Instructions: Part 1, setup

Add Devise to your Gemfile:

    gem 'devise'

Now run the installer:

    rails generate devise:install

This creates a massive initializer in `config/initializers/devise.rb`. This is probably the single best source of documentation for Devise that I've seen. You may wish to look through it.

You'll notice that the installer prints a big notice of several things you should do. In particular, we should have a root route.

Create a `WelcomeController` with a `home` action and a view that just prints `current_user.email`.

Now generate your `User` model with:

    rails g devise User

Run `rake routes` and `rake db:migrate`. You should see that Devise has added a bunch of them. Run `rails s` and take a look at one, maybe `/users/sign_in`.

You should now have a working app with sign in.

## Part 2, customization

Now let's add Facebook login support with Omniauth.

Add omniauth-facebook to your Gemfile:

    gem 'omniauth-facebook'

We'll also need to store two more columns in our user model: a `provider` string (which will always be `'facebook'` or `nil` in our app for the moment), and a `uid`, the user's authenticated Facebook ID.

    rails g migration AddOmniauthToUsers provider:index uid:index
    rake db:migrate

And add the Omniauth configuration to `config/initializers/devise.rb`:

    config.omniauth :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']

You'll see that there's another similar line commented out for Github; feel free to reference it. This requires that you have `FACEBOOK_KEY` and `FACEBOOK_SECRET` in your environment. Create an application in the [Facebook developer console][fbdev] and get these values from there. You'll also need to go to +Add Product in the sidebar menu on the left. This will bring you to the Product Setup page. Here click 'get started' for Facebook Login and set Valid OAuth Redirect URLs to include `http://localhost:3000/users/auth/facebook/callback`. This setting is listed under `Client OAuth Settings` in the dashboard, and yes, I wish I could link you right to it.

Confusingly, `FACEBOOK_KEY` is called appId in the console. Set the values in your shell like so,

    export FACEBOOK_KEY=your_app_id
    export FACEBOOK_SECRET=your_app_secret

Add this line to your `user.rb` to enable omniauth:

    devise :omniauthable, :omniauth_providers => [:facebook]

And add this line to your welcome view:

     <%= link_to "Sign in with Facebook", user_facebook_omniauth_authorize_path %>

If you visit the welcome page and click "Sign in with Facebook," you should be able to go through a Facebook application authorization flow.

When you return to your app, you'll be greeted with an error: `The action 'facebook' could not be found for Devise::OmniauthCallbacksController`. Okay, let's make one.

Add this to `routes.rb` to create a route for Omniauth to send its authentication data to:

    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

Now add a file `app/controllers/users/omniauth_callbacks_controller.rb`:

    class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
      def facebook
        # TODO
      end
    end

The action should have the same name as the provider. In this case, Facebook.

Now we have to write some code to handle the Omniauth callback.

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

Here we look for a user with that (provider: :facebook, uid: your_uid) pair and create them if they aren't in the database. For Facebook users, we create a random password. The expectation is that users logging in with Facebook don't subsequently want to set a password.

You should now see a missing template error. But wait, didn't we say `sign_in_and_redirect`? Where are we being redirected to?

It turns out that Devise doesn't know automatically. We have to write a method in our `ApplicationController`:

    def after_sign_in_path_for(resource)
      request.env['omniauth.origin'] || root_path
    end

## Hiccups

If Devise doesn't seem able to get an email from Facebook, you may have to de-authorize and re-authorize your application in your Facebook privacy settings.

Your Rails server must be run from the same shell window/tab as where you set your ENV variables.

[Devise]: https://github.com/plataformatec/devise
[fbdev]: https://developer.facebook.com

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/devise_lab'>Devise Lab</a> on Learn.co and start learning to code for free.</p>
