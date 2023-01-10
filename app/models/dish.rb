class Dish < ApplicationRecord
  validates_presence_of :name, :description
  has_many :chef_dishes
  has_many :dishes, through: :chef_dishes
  has_many :dish_ingredients
  has_many :ingredients, through: :dish_ingredients

  def calorie_count
    ingredients.sum(:calories)
  end
end