class PerfisController < ApplicationController
  before_action :set_perfil, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /perfis
  def index
    @perfis = Perfil.select_lista
                        .pesquisar(params[:s])
                        .paginate(page: params[:page], per_page: params_per_page(params[:per_page]))
  end

  # GET /perfis/:id
  def show
  end

  # GET /perfis/new
  def new
    @perfil = Perfil.new
  end

  # GET /perfis/:id/edit
  def edit
  end

  # POST /perfis
  def create
    @perfil = Perfil.new(perfil_params)

    if @perfil.save
      redirect_to perfis_path, notice: 'Perfil criado com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /perfis/:id
  def update
    if @perfil.update(perfil_params)
      redirect_to perfis_path, notice: 'Perfil alterado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /perfis/:id
  def destroy
    if @perfil.destroy
      redirect_to perfis_path, notice: 'Perfil excluído com sucesso.'
    else
      redirect_to perfis_path, alert: @perfil.errors.full_messages
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
