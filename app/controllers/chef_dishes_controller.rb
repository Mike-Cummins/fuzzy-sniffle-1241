class ChefDishesController < ApplicationController
  def create
    dish = Dish.find(params[:dish_id])
    chef = Chef.find(params[:chef_id])
    ChefDish.create!(dish: dish, chef: chef)
    
    redirect_to chef_path(params[:chef_id])
  end
end