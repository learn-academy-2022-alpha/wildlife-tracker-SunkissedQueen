class SightingsController < ApplicationController

  def index
    sightings = Sighting.where(date: params[:start_date]..params[:end_date])
    render json: sightings.as_json(include: :chicken)
  end
  
  def create
    sighting = Chicken.find(params[:chicken_id]).sightings.create(sighting_params)
    if sighting.valid?
      render json: sighting.as_json(include: :chicken)
    else
      render json: sighting.errors
    end
  end

  def update
    one_sight = Sighting.find(params[:id])
    one_sight.update(sighting_params)
    if one_sight.valid?
      render json: one_sight.as_json(include: :chicken)
    else
      render json: one_sight.errors
    end
  end

  def destroy
    one_sight = Sighting.find(params[:id])
    if one_sight.destroy
      render json: one_sight
    else
      render json: one_sight.errors
    end
  end

  private
  def sighting_params
    params.require(:sighting).permit(:date, :latitude, :longitude, :start_date, :end_date)
  end

end
