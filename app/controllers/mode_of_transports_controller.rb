class ModeOfTransportsController < ApplicationController
  before_action :set_mode_of_transport, only:[:show, :edit, :update, :activated, :disable]
  before_action :only => [:new, :create, :edit, :update] do
    redirect_to root_url, notice: 'Você não possui permissão para acessar esta página!' unless current_user && current_user.admin?
  end

  def new
    @mode_of_transport = ModeOfTransport.new
  end

  def create
    @mode_of_transport = ModeOfTransport.new(mode_of_transport_params)
    if @mode_of_transport.save
    redirect_to @mode_of_transport, notice: 'Modalidade de Transporte cadastrada com sucesso.'
    else
    flash.now.notice = 'Não foi possível realizar o seu cadastro.'
    render 'new'
    end
  end

  def show
    @price_by_weights = PriceByWeight.where(mode_of_transport: @mode_of_transport)
    @price_per_distances = PricePerDistance.where(mode_of_transport: @mode_of_transport)
    @delivery_times = DeliveryTime.where(mode_of_transport: @mode_of_transport)
  end

  def index
    if current_user.admin?
      @mode_of_transports = ModeOfTransport.all
    else
      @mode_of_transports = ModeOfTransport.activated
    end
  end

  def edit; end

  def update
    if @mode_of_transport.update(mode_of_transport_params)
      redirect_to @mode_of_transport, notice: 'Modalidade de Transporte atualizada com sucesso.'
    else 
      flash.now.notice = "Não foi possível atualizar a modalidade de transporte."
      render 'new'
    end     
  end

  def activated
    @mode_of_transport.activated!
    redirect_to @mode_of_transport
  end

  def disable
    @mode_of_transport.disable!
    redirect_to @mode_of_transport 
  end
  
  private

  def set_mode_of_transport 
    @mode_of_transport = ModeOfTransport.find(params[:id])
  end

  def mode_of_transport_params
    params.require(:mode_of_transport).permit(:name, :min_distance, :max_distance, :min_weight, :max_weight, :fixed_rate)
  end

end 