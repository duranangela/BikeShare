require 'rails_helper'

describe 'visiting accessory_path' do
  context 'as a visitor' do
    it 'shows all accessory information' do
      accessory_1 = Accessory.create!(title: 'thing1', description: 'description', price: 4.5, status: 0, image: 'image.jpg')
      accessory_2 = Accessory.create!(title: 'asdfkjh', description: 'sadfkjsd', price: 4.5, status: 0, image: 'image.jpg')

      visit accessory_path(accessory_1)

      expect(page).to_not have_content("#{accessory_2.title}")

      expect(page).to have_content "Title: #{accessory_1.title}"
      expect(page).to have_content "Description: #{accessory_1.description}"
      expect(page).to have_content "Price: $#{accessory_1.price}"
      expect(page).to have_css "img[src*='image.jpg']"
      expect(page).to have_button "Add to Cart"
    end
    it 'shows disabled accessories but they cannot be added to cart' do
      accessory_1 = Accessory.create!(title: 'thing1', description: 'description', price: 4, status: 1, image: 'image.jpg')

      visit accessory_path(accessory_1)

      expect(current_path).to eq accessory_path(accessory_1)

      expect(page).to_not have_button "Add to Cart"
      expect(page).to have_content "Accessory Retired"
    end
  end
end
