class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  private

  	def track_activity(trackable, action = params[:action])
  		current_user.activities.create! action: action, trackable: trackable
  	end

    def admin_user
      unless current_user && current_user.is_admin? || current_user.is_super_admin?
        redirect_to '/401'
      end
    end

  protected

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :company, :email, :password])
	    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :company, :role, :email, :password])
	  end
end
