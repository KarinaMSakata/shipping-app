class PricePerDistancesController < ApplicationController 
  before_action :set_price_per_distance, only: [:show, :edit, :update]
  before_action :only => [:new, :create, :edit, :update] do
    redirect_to root_url, notice: 'Você não possui permissão para acessar esta página!' unless current_user && current_user.admin?
  end
  
  def new
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
    @price_per_distance = PricePerDistance.new
  end

  def create
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
    @price_per_distance = PricePerDistance.new(price_per_distance_params)
    @price_per_distance.mode_of_transport = @mode_of_transport
    if @price_per_distance.save
      redirect_to @mode_of_transport, notice: 'Configuração de preço cadastrada com sucesso!'
    else
      flash.now.notice = 'Não foi possível cadastrar esta configuração de preço.'
      render 'new'
    end

  end

  def show; end

  def index
    @price_per_distances = PricePerDistance.all
  end

  def edit
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
  end

  def update
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
    @price_per_distance.mode_of_transport = @mode_of_transport
    if @price_per_distance.update(price_per_distance_params)
      redirect_to @mode_of_transport, notice: 'Valores atualizados com sucesso.'
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