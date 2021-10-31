class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admins_root_path
    when Host
      hosts_root_path
    when Guest
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    elsif resource_or_scope == :host
      new_host_session_path
    else
      root_path
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[name last_name first_name last_name_kana first_name_kana postal_code
                                               address telephone_number])
  end
end
