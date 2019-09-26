class UsuarioPerfilsController < ApplicationController
  before_action :set_usuario_perfil, only: [:show, :edit, :update, :destroy]
  before_action :carregar_associacoes, only: [:show, :new, :edit, :create, :update]
  load_and_authorize_resource only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /usuario_perfils
  def index
    @usuario_perfils = UsuarioPerfil.select_lista
                        .pesquisar(params[:s])
                        .paginate(page: params[:page], per_page: params_per_page(params[:per_page]))
  end

  # GET /usuario_perfils/:id
  def show
  end

  # GET /usuario_perfils/new
  def new
    @usuario_perfil = UsuarioPerfil.new
  end

  # GET /usuario_perfils/:id/edit
  def edit
  end

  # POST /usuario_perfils
  def create
    @usuario_perfil = UsuarioPerfil.new(usuario_perfil_params)

    if @usuario_perfil.save
      redirect_to usuario_perfils_path, notice: 'UsuarioPerfil criado com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /usuario_perfils/:id
  def update
    if @usuario_perfil.update(usuario_perfil_params)
      redirect_to usuario_perfils_path, notice: 'UsuarioPerfil alterado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /usuario_perfils/:id
  def destroy
    if @usuario_perfil.destroy
      redirect_to usuario_perfils_path, notice: 'UsuarioPerfil excluído com sucesso.'
    else
      redirect_to usuario_perfils_path, alert: @usuario_perfil.errors.full_messages
    end
  end

  private

    # Obter usuario_perfil por ID
    def set_usuario_perfil
      @usuario_perfil = UsuarioPerfil.find(params[:id])
    end

    # Carregar registros relacionados
    def carregar_associacoes
      @usuarios = Usuario.all
      @perfils = Perfil.all
    end

    # Permitir parametros utilizaveis
    def usuario_perfil_params
      params.require(:usuario_perfil).permit(
        :usuario_id,
        :perfil_id
      )
    end
end
