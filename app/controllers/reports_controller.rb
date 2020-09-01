class ReportsController < ApplicationController
  def index
  	@date_start = params[:date_start]
  	@date_end = params[:date_end]
  	@department_id = params[:department_id]
  	@user_id = params[:user_id]
    
    if @date_start.blank?
      @date_start = Time.now.strftime("%Y-%m-%d")
    end

    if @date_end.blank?
      @date_end = Time.now.strftime("%Y-%m-%d")
    end

  	@schedules = Schedule.joins(:user).where(work_date: @date_start..@date_end).order(:work_date, :in)

  	if !@department_id.blank?
  	  @schedules = @schedules.where('users.department_id': @department_id)
  	end

  	if !@user_id.blank?
  	  @schedules = @schedules.where('users.id': @user_id)
  	end

  end
end
