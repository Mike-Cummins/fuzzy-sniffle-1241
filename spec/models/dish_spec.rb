require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  it 'Calculates the total amount of calories in the dish' do
    @chef_1 = Chef.create!(name: 'Bill')
    @dish_1 = @chef_1.dishes.create!(name: 'Salad', description: 'Leafy and green')
    @lettuce = Ingredient.create!(name: 'Lettuce', calories: 50)
    @ranch = Ingredient.create!(name: 'Ranch Dressing', calories: 150)
    @crouton = Ingredient.create!(name: 'Garlic Crouton', calories: 200)
    DishIngredient.create!(dish: @dish_1, ingredient: @lettuce)
    DishIngredient.create!(dish: @dish_1, ingredient: @ranch)
    DishIngredient.create!(dish: @dish_1, ingredient: @crouton)

    expect(@dish_1.calorie_count).to eq(400)
  end
end