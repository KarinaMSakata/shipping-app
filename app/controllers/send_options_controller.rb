class SendOptionsController < ApplicationController 
  def new
    @create_os = CreateOrderOfService.find(params[:create_order_of_service_id])
    @send_option = SendOption.new
    @modes = ModeOfTransport.where(["status = :activated AND min_weight <= :cargo_weight AND max_weight >= :cargo_weight AND 
    min_distance <= :total_distance AND max_distance >= :total_distance",{activated: 2, cargo_weight:@create_os.cargo_weight, total_distance:@create_os.total_distance}] )
    @vehicle = Vehicle.find_by(["status = :in_operation AND max_load >= :cargo_weight", {in_operation: 2, cargo_weight:@create_os.cargo_weight}])
  end

  def create
    @create_os = CreateOrderOfService.find(params[:create_order_of_service_id])
    send_option_params = params.require(:send_option).permit(:mode_of_transport_id, :vehicle_id)
    if @create_os.send_options.create(send_option_params)
      redirect_to @create_os, notice: 'Modalidade e Veículo adicionados com sucesso.'
    else
      flash.now.notice = 'Não foi possível salvar sua escolha.'
      render 'new'
    end
  end
  
  def edit
    @create_os = CreateOrderOfService.find(params[:create_order_of_service_id])
    @send_option = SendOption.find(params[:id])
    @modes = ModeOfTransport.where(["status = :activated AND min_weight <= :cargo_weight AND max_weight >= :cargo_weight AND 
    min_distance <= :total_distance AND max_distance >= :total_distance",{activated: 2, cargo_weight:@create_os.cargo_weight, total_distance:@create_os.total_distance}] )
    @vehicle = Vehicle.find_by(["status = :in_operation AND max_load >= :cargo_weight", {in_operation: 2, cargo_weight:@create_os.cargo_weight}])
  end

  def update
    @create_os = CreateOrderOfService.find(params[:create_order_of_service_id])
    @send_option = SendOption.find(params[:id])
    @modes = ModeOfTransport.where(["status = :activated AND min_weight <= :cargo_weight AND max_weight >= :cargo_weight AND 
    min_distance <= :total_distance AND max_distance >= :total_distance",{activated: 2, cargo_weight:@create_os.cargo_weight, total_distance:@create_os.total_distance}] )
    @vehicle = Vehicle.find_by(["status = :in_operation AND max_load >= :cargo_weight", {in_operation: 2, cargo_weight:@create_os.cargo_weight}])
    send_option_params = params.require(:send_option).permit(:mode_of_transport_id, :vehicle_id)

    if @send_option.update(send_option_params)
      redirect_to @create_os, notice: "Modalidade alterada com sucesso."
    else
      flash.now.notice = 'Não foi possível salvar sua escolha.'
      render 'edit'
    end
  end
end