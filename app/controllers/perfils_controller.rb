class PerfilsController < ApplicationController
  before_action :set_perfil, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /perfils
  def index
    @perfils = Perfil.select_lista
                        .pesquisar(params[:s])
                        .paginate(page: params[:page], per_page: params_per_page(params[:per_page]))
  end

  # GET /perfils/:id
  def show
  end

  # GET /perfils/new
  def new
    @perfil = Perfil.new
  end

  # GET /perfils/:id/edit
  def edit
  end

  # POST /perfils
  def create
    @perfil = Perfil.new(perfil_params)

    if @perfil.save
      redirect_to perfils_path, notice: 'Perfil criado com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /perfils/:id
  def update
    if @perfil.update(perfil_params)
      redirect_to perfils_path, notice: 'Perfil alterado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /perfils/:id
  def destroy
    if @perfil.destroy
      redirect_to perfils_path, notice: 'Perfil excluído com sucesso.'
    else
      redirect_to perfils_path, alert: @perfil.errors.full_messages
    end
  end

  private

    # Obter perfil por ID
    def set_perfil
      @perfil = Perfil.find(params[:id])
    end

    # Permitir parametros utilizaveis
    def perfil_params
      params.require(:perfil).permit(
        :descricao
      )
    end
end
