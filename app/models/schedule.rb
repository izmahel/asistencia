class Schedule < ApplicationRecord
  belongs_to :authorized_by, :foreign_key => "who", :class_name => "User"
  belongs_to :user

  MAX = 50
  SECURITY_EMAIL = 'ramon.gomez@cimav.edu.mx'

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
    "Contacto con enfermo COVID-19"
  ]

end
