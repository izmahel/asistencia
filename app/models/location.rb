class Location < ApplicationRecord
  has_many :users
  has_many :departments
end
