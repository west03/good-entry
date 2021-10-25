class ApplicationController < ActionController::Base
  def confingure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[name last_name first_name last_name_kana first_name_kana postal_code
                                               address telephone_number email])
  end
end
