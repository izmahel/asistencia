class AddAppointmentIdToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :appointment_id, :integer
  end
end
