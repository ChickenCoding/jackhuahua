class Location < ActiveRecord::Base
  validates :lng, presence: true
  validates :lat, presence: true
end
