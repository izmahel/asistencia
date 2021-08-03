class Schedule < ApplicationRecord
  belongs_to :authorized_by, :foreign_key => "who", :class_name => "User"
  belongs_to :edit_by_user, :foreign_key => "edit_by", :class_name => "User", optional: true
  belongs_to :user


  SECURITY_EMAIL = 'marcos.lopez@cimav.edu.mx'

  QUESTIONS = [
    "Fiebre",
    "Tos Seca",
    "Cansancio",
    "Molestias o Dolor muscular",
    "Dolor de Garganta",
    "Congestion Nasal",
    "Diarrea",
    "Conjuntivitis",
    "Dolor de Cabeza",
    "Perdida del sentido del Olfato",
    "Perdida del sentido del Gusto",
    "Erupciones Cutaneas",
    "Perdida de color en los dedos de los pies o manos",
    "Contacto con enfermo COVID-19 sin tomar medidas de seguridad"
  ]

end
