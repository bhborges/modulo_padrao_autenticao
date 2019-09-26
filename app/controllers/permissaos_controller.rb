class PermissaosController < ApplicationController
  before_action :set_permissao, only: [:show, :edit, :update, :destroy]
  before_action :carregar_associacoes, only: [:show, :new, :edit, :create, :update]
  load_and_authorize_resource only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /permissaos
  def index
    @permissaos = Permissao.select_lista
                        .pesquisar(params[:s])
                        .paginate(page: params[:page], per_page: params_per_page(params[:per_page]))
  end

  # GET /permissaos/:id
  def show
  end

  # GET /permissaos/new
  def new
    @permissao = Permissao.new
  end

  # GET /permissaos/:id/edit
  def edit
  end

  # POST /permissaos
  def create
    @permissao = Permissao.new(permissao_params)

    if @permissao.save
      redirect_to permissaos_path, notice: 'Permissao criado com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /permissaos/:id
  def update
    if @permissao.update(permissao_params)
      redirect_to permissaos_path, notice: 'Permissao alterado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /permissaos/:id
  def destroy
    if @permissao.destroy
      redirect_to permissaos_path, notice: 'Permissao excluído com sucesso.'
    else
      redirect_to permissaos_path, alert: @permissao.errors.full_messages
    end
  end

  private

    # Obter permissao por ID
    def set_permissao
      @permissao = Permissao.find(params[:id])
    end

    # Carregar registros relacionados
    def carregar_associacoes
      @recursos = Recurso.all
      @perfils = Perfil.all
    end

    # Permitir parametros utilizaveis
    def permissao_params
      params.require(:permissao).permit(
        :recurso_id,
        :perfil_id,
        :visualizar,
        :criar,
        :atualizar,
        :excluir
      )
    end
end
