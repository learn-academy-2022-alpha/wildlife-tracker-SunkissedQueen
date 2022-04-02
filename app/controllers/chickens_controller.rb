class ChickensController < ApplicationController

  def index
    chickens = Chicken.all
    render json: chickens
  end

  def show
    one_bird = Chicken.find(params[:id])
    render json: one_bird.as_json(include: :sightings)
  end

  def create
    chick = Chicken.create(chick_params)
    if chick.valid?
      render json: chick
    else
      render json: chick.errors
    end
  end

  def update
    one_chick = Chicken.find(params[:id])
    one_chick.update(chick_params)
    if one_chick.valid?
      render json: one_chick
    else
      render json: one_chick.errors
    end
  end

  def destroy
    one_chick = Chicken.find(params[:id])
    if one_chick.destroy
      render json: one_chick
    else
      render json: one_chick.errors
    end
  end

  private
  def chick_params
    params.require(:chicken).permit(:name, :origin, :feature)
  end

end
