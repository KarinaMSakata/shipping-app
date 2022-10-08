class PriceByWeightsController < ApplicationController 
  before_action :only => [:new, :create, :edit, :update] do
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

  def index
    @price_by_weights = PriceByWeight.all
  end

  def edit
    @price_by_weight = PriceByWeight.find(params[:id])
  end

  def update
    @price_by_weight = PriceByWeight.find(params[:id])
    if @price_by_weight.update(price_by_weight_params) 
      redirect_to @price_by_weight, notice: 'Valores atualizados com sucesso.'
    else
      flash.now.notice= 'Não foi possivel atualizar os valores.'
      render 'edit'
    end
  end

  private

  def price_by_weight_params
    params.require(:price_by_weight).permit(:min_weight, :max_weight, :price_per_km)
  end
end