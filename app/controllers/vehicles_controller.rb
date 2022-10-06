class VehiclesController < ApplicationController
  before_action :only => [:new, :create] do
    redirect_to root_url, notice: 'Você não possui permissão para acessar esta página!' unless current_user && current_user.admin?
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      redirect_to @vehicle, notice: 'Veículo cadastrado com sucesso.'

    end
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  private 

  def vehicle_params 
    params.require(:vehicle).permit(:sort, :brand, :model, :identification, :year_manufacture, :max_load)
  end

end