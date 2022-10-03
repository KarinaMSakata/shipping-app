class ModeOfTransportsController < ApplicationController
  before_action :set_mode_of_transport, only:[:show, :edit, :update]

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

  def show; end

  def index
    @mode_of_transports = ModeOfTransport.all
  end

  def edit; end

  def update
    @mode_of_transport.update(mode_of_transport_params)
    redirect_to @mode_of_transport, notice: 'Modalidade de Transporte atualizada com sucesso.'
    
  end

  private

  def set_mode_of_transport 
    @mode_of_transport = ModeOfTransport.find(params[:id])
  end

  def mode_of_transport_params
    params.require(:mode_of_transport).permit(:name, :min_distance, :max_distance, :min_weight, :max_weight, :fixed_rate)
  end
end 