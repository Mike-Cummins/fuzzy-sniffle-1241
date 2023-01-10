require 'rails_helper'

RSpec.describe 'Chef Show' do
  describe 'As a user when I visit a chef show page' do
    before :each do
      @chef_1 = Chef.create!(name: 'Bill')
      @chef_2 = Chef.create!(name: 'Steve')
      @dish_1 = @chef_1.dishes.create!(name: 'Salad', description: 'Leafy and green')
      @dish_2 = @chef_1.dishes.create!(name: 'Soup', description: 'Hot and delicious')
      @dish_3 = Dish.create!(name: 'Burger', description: 'Juicy and delicious')
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
    it 'Displays the name of the chef and all their dishes' do
      visit chef_path(@chef_1.id)

      expect(page).to have_content(@chef_1.name)
      expect(page).to_not have_content(@chef_2.name)

      within "div#dishes" do
        expect(page).to have_content(@dish_1.name)
        expect(page).to have_content(@dish_2.name)
        expect(page).to_not have_content(@dish_3.name)
      end
    end
    it 'Has a form to add a dish to the chef' do
      visit chef_path(@chef_1.id)

      expect(page).to_not have_content(@dish_3.name)

      fill_in('dish_id', with: @dish_3.id)
      click_on('Add Dish')

      expect(page).to have_content(@dish_3.name)
    end
  end
end