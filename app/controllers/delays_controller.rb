class DelaysController < ApplicationController
  def new
    @create_os = CreateOrderOfService.find(params[:id])
    @delay = Delay.new
  end

 
end