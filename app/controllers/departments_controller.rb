class DepartmentsController < ApplicationController
  def show 
  	if params[:date]
      @date = params[:date]
      @tomorrow = @date.to_date.tomorrow.strftime("%Y-%m-%d")
      @yesterday = @date.to_date.yesterday.strftime("%Y-%m-%d")
    else
  	  @date = Time.now.strftime("%Y-%m-%d")
  	  @tomorrow = Time.now.tomorrow.strftime("%Y-%m-%d")
  	  @yesterday = Time.now.yesterday.strftime("%Y-%m-%d")
  	end
    @department = Department.where(user_id: current_user.id).first
    if @department.id != params[:id].to_i
      render plain: 'No autorizado', :status => 401
    end
  end 

end
