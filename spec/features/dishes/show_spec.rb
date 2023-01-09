require 'rails_helper'

RSpec.describe 'Dish Show' do
  describe 'As a user when I visit a dish show page' do
    before :each do
      @chef_1 = Chef.create!(name: 'Bill')
      @dish_1 = @chef_1.dishes.create!(name: 'Salad', description: 'Leafy and green')
      @dish_2 = @chef_1.dishes.create!(name: 'Soup', description: 'Hot and delicious')
      @lettuce = Ingredient.create!(name: 'Lettuce', calories: 50)
      @ranch = Ingredient.create!(name: 'Ranch Dressing', calories: 150)
      @crouton = Ingredient.create!(name: 'Garlic Crouton', calories: 200)
      @tomato = Ingredient.create!(name: 'Tomato', calories: 350)
      @cream = Ingredient.create!(name: 'Heavy cream', calories: 225)
      DishIngredient.create!(dish: @dish_1, ingredient: @lettuce)
      DishIngredient.create!(dish: @dish_1, ingredient: @ranch)
      DishIngredient.create!(dish: @dish_1, ingredient: @crouton)
      DishIngredient.create!(dish: @dish_2, ingredient: @tomato)
      DishIngredient.create!(dish: @dish_2, ingredient: @cream)
    end
    
    it 'Displays the name and description of the dish' do
      visit dish_path(@dish_1.id)

      expect(page).to have_content(@dish_1.name)
      expect(page).to have_content(@dish_1.description)
      expect(page).to_not have_content(@dish_2.name)
      expect(page).to_not have_content(@dish_2.description)
    end

    it 'Displays the ingredients of the dish' do
      visit dish_path(@dish_1.id)

      expect(page).to have_content(@lettuce.name)
      expect(page).to have_content(@ranch.name)
      expect(page).to have_content(@crouton.name)
      expect(page).to_not have_content(@tomato.name)
      expect(page).to_not have_content(@cream.name)
    end

    it 'Displays the total calories for the dish' do
      visit dish_path(@dish_1.id)

      expect(page).to have_content('Total Calories: 400')
    end
  end
end