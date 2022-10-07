class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :in_maintenance, :in_operation]  
  before_action :only => [:new, :create, :edit, :update] do
    redirect_to root_url, notice: 'Você não possui permissão para acessar esta página!' unless current_user && current_user.admin?
  end
  

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      redirect_to @vehicle, notice: 'Veículo cadastrado com sucesso.'
    else
      flash.now.notice = "Não foi possível cadastrar o veículo."
      render 'new'

    end
  end

  def show; end

  def index
    @vehicles = Vehicle.all
  end
  
  def edit; end

  def update
    if @vehicle.update(vehicle_params)
      redirect_to @vehicle, notice: 'Veículo editado com sucesso!'
    else
      flash.now.notice = 'Não foi possível atualizar o veículo.'
      render 'edit' 
    end
  end

  def in_operation
    @vehicle.in_operation!
    redirect_to @vehicle
  end

  def in_maintenance
    @vehicle.in_maintenance!
    redirect_to @vehicle
  end


  private 

  def vehicle_params 
    params.require(:vehicle).permit(:sort, :brand, :model, :identification, :year_manufacture, :max_load, :status)
  end
  
  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
end