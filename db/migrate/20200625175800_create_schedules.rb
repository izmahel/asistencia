class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.references :user
      t.date       :work_date
      t.boolean    :h1
      t.boolean    :h2
      t.boolean    :q1
      t.boolean    :q2
      t.boolean    :q3
      t.boolean    :q4
      t.boolean    :q5
      t.boolean    :q6
      t.boolean    :q7
      t.boolean    :q8
      t.boolean    :q9
      t.boolean    :q10
      t.boolean    :q11
      t.boolean    :q12
      t.boolean    :q13
      t.boolean    :q14
      t.text       :notes
      t.datetime   :in
      t.datetime   :out
      t.text       :user_notes
      t.timestamps
    end
  end
end
