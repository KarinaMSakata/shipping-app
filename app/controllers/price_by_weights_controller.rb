class PriceByWeightsController < ApplicationController 
  before_action :only => [:new, :create] do
    redirect_to root_url, notice: 'Você não possui permissão para acessar esta página!' unless current_user && current_user.admin?
  end
  
  def new
    @price_by_weight = PriceByWeight.new
  end

  def create
    @price_by_weight = PriceByWeight.new(price_by_weight_params)
    if @price_by_weight.save
      redirect_to @price_by_weight, notice: 'Configuração de preço cadastrada com sucesso!'
    else
      flash.now.notice = 'Não foi possível cadastrar esta configuração de preço.'
      render 'new'
    end
  end

  def show
    @price_by_weight = PriceByWeight.find(params[:id])
  end

  private

  def price_by_weight_params
    params.require(:price_by_weight).permit(:min_weight, :max_weight, :price_per_km)
  end
end