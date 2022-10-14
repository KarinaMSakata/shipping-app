class SendOptionsController < ApplicationController 
  def new
    @create_os = CreateOrderOfService.find(params[:create_order_of_service_id])
    @send_option = SendOption.new
    @modes = ModeOfTransport.where(["status = :activated AND min_weight <= :cargo_weight AND max_weight >= :cargo_weight AND 
    min_distance <= :total_distance AND max_distance >= :total_distance",{activated: 2, cargo_weight:@create_os.cargo_weight, total_distance:@create_os.total_distance}] )
    @vehicle = Vehicle.find_by(status: :in_operation)
  end

  def create
    @create_os = CreateOrderOfService.find(params[:create_order_of_service_id])
    send_option_params = params.require(:send_option).permit(:mode_of_transport_id, :vehicle_id)
    @create_os.send_options.create(send_option_params)
    redirect_to @create_os, notice: 'Modalidade e Veículo adicionados com sucesso.'
  end


 
end