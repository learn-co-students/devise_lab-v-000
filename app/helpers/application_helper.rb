module ApplicationHelper

	def session_links
		if current_user
			link_to 'Sign out', destroy_user_session_path, method: 'delete'
		end
	end
end
