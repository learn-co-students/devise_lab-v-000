class SessionsController < Devise::OmniauthCallbacksController

  def new
  end

  def destroy
    raise params.inspect
    session.delete :user_id

    redirect_to user_session_path
  end
end
