require 'rails_helper'

RSpec.describe Chicken, type: :model do
  it 'is not valid without a name' do
    foghorn_leghorn = Chicken.create origin: 'Looney Tunes', feature: 'loud, fast talker and over-explanation'
    expect(foghorn_leghorn.errors[:name]).to_not be_empty
  end
  it 'is not valid without an origin' do
    foghorn_leghorn = Chicken.create name: 'Foghorn Leghorn', feature: 'loud, fast talker and over-explanation'
    expect(foghorn_leghorn.errors[:origin]).to_not be_empty
  end
  it 'is not valid without a feature' do
    foghorn_leghorn = Chicken.create name: 'Foghorn Leghorn', origin: 'Looney Tunes'
    expect(foghorn_leghorn.errors[:feature]).to_not be_empty
  end
  it 'is not allow to have the same name and origin' do
    little = Chicken.create name: 'Chicken Little', origin: 'Chicken Little', feature: 'absurd notion that the sky is falling'
    expect(little.errors[:name]).to_not be_empty
  end 
  it 'is not allow duplicate names' do
    Chicken.create name: 'Foghorn Leghorn', origin: 'Walt Disney', feature: 'absurd notion that the sky is falling'
    foghorn_leghorn = Chicken.create name: 'Foghorn Leghorn', origin: 'Looney Tunes', feature: 'loud, fast talker and over-explanation'
    expect(foghorn_leghorn.errors[:name]).to_not be_empty
  end   
  it 'is not allow duplicate features' do
    Chicken.create name: 'Chicken Little', origin: 'Walt disney', feature: 'absurd notion that the sky is falling'
    foghorn_leghorn = Chicken.create name: 'Foghorn Leghorn', origin: 'Looney Tunes', feature: 'absurd notion that the sky is falling'
    expect(foghorn_leghorn.errors[:feature]).to_not be_empty
  end    
end
