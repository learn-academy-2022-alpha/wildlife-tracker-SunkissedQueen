class Chicken < ApplicationRecord
  has_many :sightings
  accepts_nested_attributes_for :sightings

  validates :name, :origin, :feature, presence: { message: "422 Unprocessable Entity: missing an attribute" }
  validates :name, :feature, uniqueness: { message: "422 Unprocessable Entity: element already used" }

  validate :name_and_origin_cannot_be_equal, on: :create

  def name_and_origin_cannot_be_equal
    if name == origin
      errors.add(:name, "422 Unprocessable Entity: name and origin cannot be equal")
    end
  end
end
