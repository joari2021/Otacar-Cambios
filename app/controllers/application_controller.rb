class ApplicationController < ActionController::Base
    protected

    def authenticate_normal_user!
        redirect_to edit_user_registration_path unless user_signed_in? && current_user.is_normal_user?
    end
    def authenticate_admin!
        redirect_to user_root_path unless user_signed_in? && current_user.is_admin?
    end

    def authenticate_referidor!
        unless current_user.is_normal_user?
            user = User.new(params_referido)
            num_referidor = user.num_referidor.to_i
            if num_referidor === 0
                user_find = false
            else
                if num_referidor % 2 === 0
                    num_referidor /= 4
                    referidor = User.where(id: num_referidor)

                    if referidor.present?
                        user_find = true
                    else
                        user_find = false
                    end
                else
                    user_find = false
                end
            end
            redirect_to edit_user_registration_path, alert: "El numero de usuario que ingreso en la referencia no existe" unless user_find 
        end
    end

    def params_referido
        params.require(:user).permit(:num_referidor)
    end
end
