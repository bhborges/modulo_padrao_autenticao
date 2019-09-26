class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /usuarios
  def index
    @usuarios = Usuario.select_lista
                        .pesquisar(params[:s])
                        .paginate(page: params[:page], per_page: params_per_page(params[:per_page]))
  end

  # GET /usuarios/:id
  def show
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/:id/edit
  def edit
  end

  # POST /usuarios
  def create
    @usuario = Usuario.new(usuario_params)

    if @usuario.save
      redirect_to usuarios_path, notice: 'Usuario criado com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /usuarios/:id
  def update
    if @usuario.update(usuario_params)
      redirect_to usuarios_path, notice: 'Usuario alterado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /usuarios/:id
  def destroy
    if @usuario.destroy
      redirect_to usuarios_path, notice: 'Usuario excluído com sucesso.'
    else
      redirect_to usuarios_path, alert: @usuario.errors.full_messages
    end
  end

  private

    # Obter usuario por ID
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Permitir parametros utilizaveis
    def usuario_params
      params.require(:usuario).permit(
        :nome,
        :login
      )
    end
end
