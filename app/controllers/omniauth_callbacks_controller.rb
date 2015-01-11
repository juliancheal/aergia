class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :authenticate_user!
	def all
		user = User.find_for_oauth(env["omniauth.auth"], current_user)
		if user.persisted?
			sign_in_and_redirect(user)
		else
			session["devise.user_attributes"] = user.attributes
			redirect_to new_user_registration_url
		end
	end

	  def failure
      #handle you logic here..
      #and delegate to super.
      super
   end

	alias_method :github, :all

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end
end