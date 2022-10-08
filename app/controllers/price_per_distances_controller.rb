class PricePerDistancesController < ApplicationController 
  before_action :only => [:new, :create] do
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

  def show
    @price_per_distance = PricePerDistance.find(params[:id])
  end

  private

  def price_per_distance_params 
    params.require(:price_per_distance).permit(:min_distance, :max_distance, :price)
  end
end