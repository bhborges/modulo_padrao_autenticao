class RecursosController < ApplicationController
  before_action :set_recurso, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /recursos
  def index
    @recursos = Recurso.select_lista
                        .pesquisar(params[:s])
                        .paginate(page: params[:page], per_page: params_per_page(params[:per_page]))
  end

  # GET /recursos/:id
  def show
  end

  # GET /recursos/new
  def new
    @recurso = Recurso.new
  end

  # GET /recursos/:id/edit
  def edit
  end

  # POST /recursos
  def create
    @recurso = Recurso.new(recurso_params)

    if @recurso.save
      redirect_to recursos_path, notice: 'Recurso criado com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /recursos/:id
  def update
    if @recurso.update(recurso_params)
      redirect_to recursos_path, notice: 'Recurso alterado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /recursos/:id
  def destroy
    if @recurso.destroy
      redirect_to recursos_path, notice: 'Recurso excluído com sucesso.'
    else
      redirect_to recursos_path, alert: @recurso.errors.full_messages
    end
  end

  private

    # Obter recurso por ID
    def set_recurso
      @recurso = Recurso.find(params[:id])
    end

    # Permitir parametros utilizaveis
    def recurso_params
      params.require(:recurso).permit(
        :nome,
        :descricao,
        :tipo
      )
    end
end
