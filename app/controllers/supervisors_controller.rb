class SupervisorsController < ApplicationController
  def my_students
  	@students = current_user.student_supervisor.order("is_advisor DESC")
  end

  def add_supervisor
  	user = User.find(params[:user_id])
  	sup = user.student_supervisor.new
  	sup.student_id = params[:student_id]
  	if sup.save
  	  redirect_to '/mis-estudiantes'
  	end
  end

  def delete_supervisor
  	sup = StudentSupervisor.find(params[:sup_id])
  	if sup.destroy
  	  redirect_to '/mis-estudiantes'
  	end
  end

end
