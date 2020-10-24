class ApplicationController < ActionController::Base
    protected

    def authenticate_normal_user!
        redirect_to edit_user_registration_path unless user_signed_in? && current_user.is_normal_user?
    end
    def authenticate_admin!
        redirect_to user_root_path unless user_signed_in? && current_user.is_admin?
    end
end
