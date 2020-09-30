class AsistenciaMailer < ApplicationMailer
  def send_buzon(schedule)

    @schedule = schedule

    @from = "Notificaciones CIMAV <notificaciones@cimav.edu.mx>"
    emails = "#{Schedule::SECURITY_EMAIL}"
    schedule.user.supervisors.each do |s|
      if s.is_advisor
      	@advisor = s.user
      	emails = emails + "," + s.user.email
      end
    end

    mail(to: emails,  :from => @from, subject: "[ASISTENCIA] #{@schedule.user.first_name} #{@schedule.user.last_name} excedió el tiempo de su cita programada")
  end
end
