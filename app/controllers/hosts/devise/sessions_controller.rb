# frozen_string_literal: true

class Hosts::Devise::SessionsController < Devise::SessionsController
  before_action :reject_inactive_host, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def reject_inactive_host
    @host = Host.find_by(email: params[:host][:email])
    if @host
      if @host.valid_password?(params[:host][:password])&& !@host.is_active
        redirect_to new_host_session_path
      end
    end
  end
end
