module WelcomeHelper
  def welcome_message_for(current_user)
    if current_user
      "Welcome, #{current_user.email}!"
    else
      "Welcome!"
    end
  end

  def navbar_login_for(current_user)
    if current_user
      link_to "Sign out", destroy_user_session_path, method: "delete"
    else
      link_to "Sign up", new_user_registration_path
    end
  end

  def error_content_tag(flash)
    unless flash.keys.empty?
      flash_type = flash.keys.first.to_sym
      content_tag :div, flash[flash_type], id: "flash_#{flash_type}" if flash_type
    end
  end
end
