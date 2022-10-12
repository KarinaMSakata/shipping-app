class PriceByWeightsController < ApplicationController 
  before_action :set_price_by_weight, only: [:show, :edit, :update]
  before_action :only => [:new, :create, :edit, :update] do
    redirect_to root_url, notice: 'Você não possui permissão para acessar esta página!' unless current_user && current_user.admin?
  end
  
  def new
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
    @price_by_weight = PriceByWeight.new
  end

  def create
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
    @price_by_weight = PriceByWeight.new(price_by_weight_params)
    @price_by_weight.mode_of_transport = @mode_of_transport
    if @price_by_weight.save
      redirect_to @mode_of_transport, notice: 'Configuração de preço cadastrada com sucesso!'
    else
      flash.now.notice = 'Não foi possível cadastrar esta configuração de preço.'
      render 'new'
    end
  end

  def show; end

  def index
    @price_by_weights = PriceByWeight.all
  end

  def edit
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
  end

  def update
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
    @price_by_weight.mode_of_transport = @mode_of_transport
    if @price_by_weight.update(price_by_weight_params) 
      redirect_to @mode_of_transport, notice: 'Valores atualizados com sucesso.'
    else
      flash.now.notice= 'Não foi possivel atualizar os valores.'
      render 'edit'
    end
  end

  private

  def price_by_weight_params
    params.require(:price_by_weight).permit(:min_weight, :max_weight, :price_per_km)
  end

  def set_price_by_weight 
    @price_by_weight = PriceByWeight.find(params[:id])
  end
end