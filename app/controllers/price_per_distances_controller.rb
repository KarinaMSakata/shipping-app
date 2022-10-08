class PricePerDistancesController < ApplicationController 
  before_action :set_price_per_distance, only: [:show, :edit, :update]
  before_action :only => [:new, :create, :edit, :update] do
    redirect_to root_url, notice: 'Você não possui permissão para acessar esta página!' unless current_user && current_user.admin?
  end
  
  def new
    @price_per_distance = PricePerDistance.new
  end

  def create
    @price_per_distance = PricePerDistance.new(price_per_distance_params)
    if @price_per_distance.save
      redirect_to @price_per_distance, notice: 'Configuração de preço cadastrada com sucesso!'
    else
      flash.now.notice = 'Não foi possível cadastrar esta configuração de preço.'
      render 'new'
    end

  end

  def show; end

  def index
    @price_per_distances = PricePerDistance.all
  end

  def edit; end

  def update
    if @price_per_distance.update(price_per_distance_params)
      redirect_to @price_per_distance, notice: 'Valores atualizados com sucesso.'
    else
      flash.now.notice = 'Não foi possivel atualizar os valores.'
      render 'edit'
    end


  end

  private

  def price_per_distance_params 
    params.require(:price_per_distance).permit(:min_distance, :max_distance, :price)
  end

  def set_price_per_distance
    @price_per_distance = PricePerDistance.find(params[:id])
  end
end