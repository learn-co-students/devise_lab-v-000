module ApplicationHelper
  def sign_in_sign_out
    content_tag(:div) do
      if user_signed_in?
        link_to('Sign out', destroy_user_session_path, method: :delete) if user_signed_in?
      else
        link_to('Login', new_user_session_path)
      end
    end
  end
end
