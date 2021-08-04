class ReportsController < ApplicationController
  def index
  	@date_start = params[:date_start]
  	@date_end = params[:date_end]
  	@department_id = params[:department_id]
    @rh_group = params[:rh_group]
  	@user_id = params[:user_id]


    @show_students = false


    if params[:show_type] == 'A' 
      @show_students = true
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

    if params[:show_type] == 'E' 
      @schedules = @schedules.where('users.is_student': false).where("users.rh_level <> 'CAT'")
    end

    if params[:show_type] == 'C' 
      @schedules = @schedules.where('users.rh_level': 'CAT')
    end

    if params[:show_type] == 'A' 
      @schedules = @schedules.where('users.is_student': true)
    end

    if !@rh_group.blank?
      @schedules = @schedules.where('users.rh_group': @rh_group)
    end

  end

  def xls
    @date_start = params[:date_start]
    @date_end = params[:date_end]
    @department_id = params[:department_id]
    @rh_group = params[:rh_group]
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

    if !@rh_group.blank?
      @schedules = @schedules.where('users.rh_group': @rh_group)
    end

    p = Axlsx::Package.new
    wb = p.workbook

    wb.add_worksheet(name: 'Asistencia') do |sheet|
      sheet.add_row ['ID', 'Nombre', 'Grupo', 'Nivel', 'Departamento', 'Fecha', 'Motivo', 'Autorizó', 'Entrada', 'Salida']
      @schedules.each do |s|
        id = s.user.rh_id rescue '--'
        nombre = s.user.fullname rescue '--'
        grupo = s.user.rh_group rescue '--'
        nivel = s.user.rh_level rescue '--'
        departamento = s.user.department.name rescue '--'
        fecha = s.work_date rescue '--'
        motivo = s.notes rescue '--'
        autorizo = s.authorized_by.fullname rescue '--'
        entrada = s.in.strftime("%I:%M%p") rescue '--'
        salida = s.out.strftime("%I:%M%p") rescue '--'
        sheet.add_row [id, nombre, grupo, nivel, departamento, fecha, motivo, autorizo, entrada, salida]
      end 
    end
  
    p.serialize 'reporte.xlsx'
    render :file => 'reporte.xlsx'

  end

end
