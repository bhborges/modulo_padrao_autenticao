class OdisseiasController < ApplicationController
  before_action :set_odisseia, only: [:show, :edit, :update, :destroy]
  #load_and_authorize_resource only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET /odisseias
  def index
    @odisseias = Odisseia.select_lista
                        .pesquisar(params[:s])
                        .paginate(page: params[:page], per_page: params_per_page(params[:per_page]))
  end

  # GET /odisseias/:id
  def show
  end

  # GET /odisseias/new
  def new
    @odisseia = Odisseia.new
  end

  # GET /odisseias/:id/edit
  def edit
  end

  # POST /odisseias
  def create
    @odisseia = Odisseia.new(odisseia_params)

    if @odisseia.save
      redirect_to odisseias_path, notice: 'Odisseia criado com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /odisseias/:id
  def update
    if @odisseia.update(odisseia_params)
      redirect_to odisseias_path, notice: 'Odisseia alterado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /odisseias/:id
  def destroy
    if @odisseia.destroy
      redirect_to odisseias_path, notice: 'Odisseia excluído com sucesso.'
    else
      redirect_to odisseias_path, alert: @odisseia.errors.full_messages
    end
  end

  private

    # Obter odisseia por ID
    def set_odisseia
      @odisseia = Odisseia.find(params[:id])
    end

    # Permitir parametros utilizaveis
    def odisseia_params
      params.require(:odisseia).permit(
        :texto,
        :fonte
      )
    end
end
