class ChefsController < ApplicationController
  def show
    @chef = Chef.find(params[:id])
  end

  def update
    chef = Chef.find(params[:id])
    # dish = Dish.find(params[:dish_id])
    require 'pry'; binding.pry

    redirect_to "/chefs/#{chef.id}"
  end
  private

  def chef_params
    params.permit()
  end
end