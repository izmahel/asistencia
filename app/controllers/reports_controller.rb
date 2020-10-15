class ReportsController < ApplicationController
  def index
  	@date_start = params[:date_start]
  	@date_end = params[:date_end]
  	@department_id = params[:department_id]
  	@user_id = params[:user_id]

    if params[:show_students].to_i == 1
      @show_students = true
    else
      @show_students = false
    end
    
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

  def xls
    @date_start = params[:date_start]
    @date_end = params[:date_end]
    @department_id = params[:department_id]
    @user_id = params[:user_id]

    if params[:show_students].to_i == 1
      @show_students = true
    else
      @show_students = false
    end
    
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

    p = Axlsx::Package.new
    wb = p.workbook

    wb.add_worksheet(name: 'Asistencia') do |sheet|
      sheet.add_row ['Nombre', 'Departamento', 'Fecha', 'Motivo', 'Autorizó', 'Entrada', 'Salida']
      @schedules.each do |s|
        nombre = s.user.fullname
        departamento = s.user.department.name
        fecha = s.work_date
        motivo = s.notes
        autorizo = s.authorized_by.fullname
        entrada = s.in.strftime("%I:%M%p") rescue '--'
        salida = s.out.strftime("%I:%M%p") rescue '--'
        sheet.add_row [nombre, departamento, fecha, motivo, autorizo, entrada, salida]
      end 
    end
  
    p.serialize 'reporte.xlsx'
    render :file => 'reporte.xlsx'

  end

end
