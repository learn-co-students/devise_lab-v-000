// The first step when loading your web page is figuring out if a person is already logged into your app with Facebook login. You start that process with a call to FB.getLoginStatus. That function will trigger a call to Facebook to get the login status and call your callback function with the results.
// Taken from the sample code above, here's some of the code that's run during page load to check a person's login status:


FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
});

// The response object that's provided to your callback contains a number of fields:


{
    status: 'connected',
    authResponse: {
        accessToken: '...',
        expiresIn:'...',
        signedRequest:'...',
        userID:'...'
    }
}

// status specifies the login status of the person using the app. The status can be one of the following:
	// connected - the person is logged into Facebook, and has logged into your app.
	// not_authorized - the person is logged into Facebook, but has not logged into your app.
	// unknown - the person is not logged into Facebook, so you don't know if they've logged into your app or FB.logout() was called before and therefore, it cannot connect to Facebook.
// authResponse is included if the status is connected and is made up of the following:
	// accessToken - contains an access token for the person using the app.
	// expiresIn - indicates the UNIX time when the token expires and needs to be renewed.
	// signedRequest - a signed parameter that contains information about the person using the app.
	// userID - the ID of the person using the app.
// Once your app knows the login status of the person using it, it can do one of the following:
	// If the person is logged into Facebook and your app, redirect them to your app's logged in experience.
	// If the person isn't logged into your app, or isn't logged into Facebook, prompt them with the Login dialog with FB.login() or show them the Login Button.




