class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2 #method name matches provider
    @user = User.from_omniauth(request.env["omniauth.auth"])

    # user = ::User.from_omniauth(oath_response)

    if @user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: provider)

      sign_in_and_redirect @user
    # else
    #   session["devise.google.data"] = oauth_response.expect(:extra)
    #   params[:error] = :account_not_found
    #   do_failure_things
    # end
  end
end
