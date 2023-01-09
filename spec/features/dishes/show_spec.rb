require 'rails_helper'

RSpec.describe 'Dish Show' do
  describe 'As a user when I visit a dish show page' do
    before :each do
      @chef_1 = Chef.create!(name: 'Bill')
      @dish_1 = @chef_1.dishes.create!(name: 'Salad', description: 'Leafy and green')
      @dish_2 = @chef_1.dishes.create!(name: 'Soup', description: 'Hot and delicious')

    end
    it 'Displays the name and description of the dish' do
      visit dish_path(@dish_1.id)

      expect(page).to have_content(@dish_1.name)
      expect(page).to have_content(@dish_1.description)
      expect(page).to_not have_content(@dish_2.name)
      expect(page).to_not have_content(@dish_2.description)
    end
  end
end