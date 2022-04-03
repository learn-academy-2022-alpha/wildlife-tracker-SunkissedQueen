require 'rails_helper'

RSpec.describe Sighting, type: :model do
  it 'is not valid without a date' do
    hen = Sighting.create latitude:"36.7783N", longitude:"119.4179W"
    expect(hen.errors[:date]).to_not be_empty
  end
  it 'is not valid without a latitude' do
    hen = Sighting.create date:"2022-01-28 05:40:30", longitude:"119.4179W"
    expect(hen.errors[:latitude]).to_not be_empty
  end
  it 'is not valid without a longitude' do
    hen = Sighting.create date:"2022-01-28 05:40:30", latitude:"36.7783N"
    expect(hen.errors[:longitude]).to_not be_empty
  end
end
