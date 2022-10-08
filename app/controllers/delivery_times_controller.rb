class DeliveryTimesController < ApplicationController
  before_action :set_delivery_time, only: [:show]
  before_action :only => [:new, :create] do
    redirect_to root_url, notice: 'Você não possui permissão para acessar esta página!' unless current_user && current_user.admin?
  end

  def new
    @delivery_time = DeliveryTime.new
  end

  def create
    @delivery_time = DeliveryTime.new(delivery_time_params)
    if @delivery_time.save
      redirect_to @delivery_time, notice: 'Prazo de Entrega cadastrado com sucesso!'
    else
      flash.now.notice = "Não foi possível cadastrar esta configuração de preço."
      render 'new'
    end
  end

  def show
  end

  private

  def delivery_time_params
    params.require(:delivery_time).permit(:origin, :destination, :hours)
  end

  def set_delivery_time
    @delivery_time = DeliveryTime.find(params[:id])
  end
end