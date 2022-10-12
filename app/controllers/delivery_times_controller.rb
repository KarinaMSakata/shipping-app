class DeliveryTimesController < ApplicationController
  before_action :set_delivery_time, only: [:show, :edit, :update]
  before_action :only => [:new, :create, :edit, :update] do
    redirect_to root_url, notice: 'Você não possui permissão para acessar esta página!' unless current_user && current_user.admin?
  end

  def new
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
    @delivery_time = DeliveryTime.new
  end

  def create
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
    @delivery_time = DeliveryTime.new(delivery_time_params)
    @delivery_time.mode_of_transport = @mode_of_transport
    if @delivery_time.save
      redirect_to @mode_of_transport, notice: 'Prazo de Entrega cadastrado com sucesso!'
    else
      flash.now.notice = "Não foi possível cadastrar esta configuração de preço."
      render 'new'
    end
  end

  def show; end

  def index
    @delivery_times = DeliveryTime.all
  end

  def edit
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
  end

  def update
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
    @delivery_time.mode_of_transport = @mode_of_transport
    if @delivery_time.update(delivery_time_params)
      redirect_to @mode_of_transport, notice: 'Prazo atualizado com sucesso!'
    else
      flash.now.notice = 'Não foi possível atualizar este prazo.'
      render 'edit'
    end
  end

  private

  def delivery_time_params
    params.require(:delivery_time).permit(:origin, :destination, :hours)
  end

  def set_delivery_time
    @delivery_time = DeliveryTime.find(params[:id])
  end
end