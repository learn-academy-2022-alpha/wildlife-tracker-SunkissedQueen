class Sighting < ApplicationRecord
  belongs_to :chicken

  validates :date, :latitude, :longitude, presence: { message: "422 Unprocessable Entity: missing an attribute" }
  
  validates :latitude, :longitude, uniqueness: { message: "422 Unprocessable Entity: element already used" }

  validate :latitude_and_longitude_cannot_be_equal, on: :create

  def latitude_and_longitude_cannot_be_equal
    if latitude == longitude
      errors.add(:latitude, "422 Unprocessable Entity: latitude and longitude cannot be equal")
    end
  end
end
