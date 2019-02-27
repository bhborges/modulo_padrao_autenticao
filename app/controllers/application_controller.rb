class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Common

  # Callbacks
  before_action :authenticate_usuario!
  # before_action :verificar_login!

  # Manipular excessões de permissões do CanCanCan
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: 'Você não tem permissão para acessar essa página.'
  end

  # Configuracao requerida pelo CanCan
  def current_ability
    @current_ability ||= ::Ability.new(current_usuario)
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
