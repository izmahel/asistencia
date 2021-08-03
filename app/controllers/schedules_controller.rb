class SchedulesController < ApplicationController
  before_action :auth_required, only: [:index, :my_schedules, :save, :save_checklist, :occupation ]
  before_action :register_auth_required, only: [:register, :register_in, :register_out, :check_in, :check_out, :save_out ]

  def index 
  	@today_schedule = Schedule.where(user_id: current_user.id, work_date: Date.today).first

    # Generar schedule Hack
    if !@today_schedule
      sql ="SELECT C.id, labcitas_production.appointments.appointment_date, start, end, D.id, labcitas_production.appointments.id, labcitas_production.laboratories.name, laboratory_id FROM labcitas_production.appointments LEFT JOIN labcitas_production.students A ON student_id = A.id LEFT JOIN labcitas_production.users B ON appointments.user_id = B.id LEFT JOIN users C ON A.email_cimav = C.email LEFT JOIN users D ON B.email = D.email LEFT JOIN labcitas_production.laboratories ON appointments.laboratory_id = laboratories.id WHERE appointment_date = '#{Date.today}' AND A.email_cimav = '#{current_user.email}'"
      records_array = ActiveRecord::Base.connection.execute(sql)
      if records_array.present?
        records_array.each do |row|
          @today_schedule = Schedule.new
          @today_schedule.user_id = row[0]
          @today_schedule.work_date = row[1] 
          @today_schedule.start = row[2] 
          @today_schedule.end = row[3] 
          @today_schedule.who  = row[4]  
          @today_schedule.appointment_id = row[5] 
          @today_schedule.notes  = row[6]
          @today_schedule.laboratory_id  = row[7]
          @today_schedule.save!
        end
      end
    end 
  end

  def edit 
     @schedule = Schedule.find(params[:id])
  end

  def save_edit 
    schedule = Schedule.find(params[:id])
    schedule.temperature = params[:temperature]
    if params[:in].blank? 
      schedule.in =  nil
    else
      schedule.in =  params[:in] 
    end
    if params[:out].blank?
      schedule.out =  params[:out]
    else
      schedule.out =  nil
    end
    schedule.edit_by = current_user.id
    schedule.edit_notes =  params[:edit_notes]
    schedule.edit_date = Time.now
    if schedule.save!
      redirect_to '/reporte'
    end
  end



  def occupation
    @date = Time.now.strftime("%Y-%m-%d")
    @schedules = Schedule.where(work_date: @date, out: nil).where.not(in: nil).order(:in)
    @employees = User.where(status: User::ACTIVE).where.not(is_student: 1).where.not(department_id: 26).where.not(department_id: 2)
  end

  def my_schedules
    @schedules = Schedule.where(user_id: current_user.id).order(work_date: :desc)
    @today_schedule = Schedule.where(user_id: current_user.id, work_date: Date.today).first
  end 

  def save 
  	schedule = Schedule.where(work_date: params[:work_date], user_id: params[:user_id]).first

  	if !schedule
  	  schedule = Schedule.new
  	  schedule.work_date = params[:work_date]
  	  schedule.user_id = params[:user_id]
  	end

  	schedule.h1 = params[:h1]
  	schedule.h2 = params[:h2]
  	schedule.notes = params[:notes]
  	schedule.who = current_user.id

  	if !schedule.h1  && !schedule.h2
  	  schedule.notes = ''
  	end

  	if schedule.save!
  	  render json: schedule
  	end
  end

  def save_checklist
    schedule = Schedule.where(id: params[:id], user_id: current_user.id).first
    c = 0
    passed = true
    Schedule::QUESTIONS.each do |q| 
      c = c + 1 
      schedule["q#{c}"] = params["q#{c}"]
      passed = false if schedule["q#{c}"] 
    end
    schedule.user_notes = params[:user_notes]
    schedule.passed = passed

    if schedule.save!
  	  redirect_to '/'
  	end
  end

  def register_login
    session[:register_session] = "no-iniciada"
    puts session
    render layout: false
  end

  def register_do_login
    if params[:password].to_s == 'caseta2020'
      session[:register_session] = "iniciada"
      redirect_to '/registro'
    else 
      redirect_to '/registro/login?fail=true'
    end
  end

  def register_logout 
    reset_session
    redirect_to '/registro/login'
  end

  def register
  	if params[:date]
      @date = params[:date]
      @tomorrow = @date.to_date.tomorrow.strftime("%Y-%m-%d")
      @yesterday = @date.to_date.yesterday.strftime("%Y-%m-%d")
    else
  	  @date = Time.now.strftime("%Y-%m-%d")
  	  @tomorrow = Time.now.tomorrow.strftime("%Y-%m-%d")
  	  @yesterday = Time.now.yesterday.strftime("%Y-%m-%d")
  	end
  	@schedules = Schedule.where(work_date: @date)
    render layout: 'register'
  end

  def register_in
    @schedules = Schedule.joins(:user).where(in: nil, work_date: Date.today, passed: true).order(:first_name, :last_name)
  	render layout: 'register'
  end

  def register_out
  	@schedules = Schedule.where(out: nil, passed: true).where.not(in: nil)
    render layout: 'register'
  end

  def check_in
  	@schedule = Schedule.where(id: params[:id], passed: true).first
  	render layout: 'register'
  end


  def save_in
  	schedule = Schedule.find(params[:id])
  	schedule.temperature = params[:temperature]
  	schedule.in = Time.now
  	if schedule.save!
  	  redirect_to '/registro/entradas'
  	end
  end

  def check_out
    @schedule = Schedule.where(id: params[:id], passed: true).first
  	render layout: 'register'
  end
  
  def save_out
  	schedule = Schedule.find(params[:id])
    schedule.out_notes = params[:out_notes]
  	schedule.out = Time.now
  	if schedule.save!
      if schedule.user.is_student
        time = "#{DateTime.now.hour}#{DateTime.now.minute.to_s.rjust(2, '0')}".to_i
        if time > schedule.end.to_i
          # Enviar correo a supervisor y comisión de seguridad
          puts "Envia------------------"
          AsistenciaMailer.notice_supervisor(schedule).deliver_now          
        end 
      end
  	  redirect_to '/registro/salidas'
  	end
  end

  def employees
    @employees = User.where(status: User::ACTIVE).order(:last_name, :first_name)
  end

  def students
    @employees = User.where(status: User::ACTIVE).order(:last_name, :first_name)
  end

  def toggle_course
    @employee = User.find(params[:user_id])
    if !@employee.course 
      @employee.course = true
    else 
      @employee.course = false
    end
    if @employee.save
      render json: @employee
    else
      puts "ERROR" 
      @employee.errors.each{|attr,err| puts "#{attr} - #{err.type}" }
      
    end
  end

  def toggle_unlimited
    @employee = User.find(params[:user_id])
    if !@employee.unlimited 
      @employee.unlimited = true
    else 
      @employee.unlimited = false
    end
    @employee.save
    render json: @employee
  end

  def toggle_vulnerable
    @employee = User.find(params[:user_id])
    if !@employee.vulnerable 
      @employee.vulnerable = true
    else 
      @employee.vulnerable = false
    end
    @employee.save
    render json: @employee
  end

  def generate_unlimited 
    schedule = Schedule.new
    schedule.work_date = Time.now.strftime("%Y-%m-%d")
    schedule.user_id = current_user.id
    schedule.who = current_user.id
    schedule.h1 = true
    schedule.h2 = true
    schedule.notes = params[:notes]
    schedule.save!
    render json: schedule
  end

end
