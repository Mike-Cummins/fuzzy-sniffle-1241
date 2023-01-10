require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :chef_dishes}
    it {should have_many(:dishes).through(:chef_dishes)}
    it {should have_many(:ingredients).through(:dishes)}
  end

  it 'Shows a unique list of all ingredients' do
    @chef_1 = Chef.create!(name: 'Bill')
    @dish_1 = @chef_1.dishes.create!(name: 'Salad', description: 'Leafy and green')
    @dish_2 = @chef_1.dishes.create!(name: 'GF Salad', description: 'Leafy and green and gluten free')
    @lettuce = Ingredient.create!(name: 'Lettuce', calories: 50)
    @ranch = Ingredient.create!(name: 'Ranch Dressing', calories: 150)
    @crouton = Ingredient.create!(name: 'Garlic Crouton', calories: 200)
    DishIngredient.create!(dish: @dish_1, ingredient: @lettuce)
    DishIngredient.create!(dish: @dish_1, ingredient: @ranch)
    DishIngredient.create!(dish: @dish_1, ingredient: @crouton)
    DishIngredient.create!(dish: @dish_2, ingredient: @lettuce)
    DishIngredient.create!(dish: @dish_2, ingredient: @ranch)

    expect(@chef_1.all_ingredients).to eq([@lettuce, @ranch, @crouton])
  end
end