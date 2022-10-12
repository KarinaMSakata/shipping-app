class CreateOrderOfServicesController < ApplicationController 
  before_action :set_create_os, only: [:show, :edit, :update]
  before_action :only => [:new, :create, :edit, :update] do
    redirect_to root_url, notice: 'Você não possui permissão para acessar esta página!' unless current_user && current_user.admin?
  end

  def new
    @create_os = CreateOrderOfService.new
  end

  def create
    @create_os = CreateOrderOfService.new(create_os_params)
    if @create_os.save
      redirect_to @create_os, notice: 'Ordem de Serviço cadastrada com sucesso.'
    else
      flash.now.notice = "Não foi possível cadastrar esta ordem de serviço"
      render 'new'
    end
  end

  def show; end

  def index
    @create_orders = CreateOrderOfService.pending
  end

  def edit; end

  def update
    if @create_os.update(create_os_params)
      redirect_to @create_os, notice: "Ordem de Serviço atualizada com sucesso."
    else
      flash.now.notice= 'Não foi possível atualizar a ordem de serviço.'
      render 'edit'
    end  
  end

  private

  def create_os_params
    params.require(:create_order_of_service).permit(:output_address, :output_city, :output_state, :product_code, 
                                                    :height, :width, :depth, :cargo_weight, :receiver_address, :receiver_city,
                                                    :receiver_state, :receiver_name, :receiver_cpf, :receiver_birth, :total_distance, :code)
  end

  def set_create_os
    @create_os = CreateOrderOfService.find(params[:id])
  end
end