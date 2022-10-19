class FeedbacksController < ApplicationController
  def new
    @create_os = CreateOrderOfService.find(params[:id])
    @feedback = Feedback.new
  end
  
  def create
    @create_os = CreateOrderOfService.find(params[:create_order_of_service_id])
    @create_os.feedbacks.create(feedback_params)
    redirect_to end_order_create_order_of_service_url(@create_os.id)
  end

  def feedback_params
    params.require(:feedback).permit(:description)
  end
 
end