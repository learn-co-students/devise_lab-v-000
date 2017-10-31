module ApplicationHelper


  def signout_link
    if is_signed_in
      link_to "Sign Out", destroy_user_session_path, method: :delete, id: "Sign out"
    end
  end

  def is_signed_in
    !!current_user
  end

end
