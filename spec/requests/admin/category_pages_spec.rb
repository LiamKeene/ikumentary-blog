require 'spec_helper'

describe 'Category Pages' do

  subject { page }

  describe 'index' do
    let(:categories) { FactoryGirl.create_list(:category, 5) }
    before { visit admin_categories_path }

    it { expect(page).to have_title_and_content('All Categories', 'All Categories') }

    it 'should tabulate each category' do
      Category.all.each do |category|
        expect(page).to have_selector('td', text: category.display_name)
      end
    end
  end

  describe 'new category page' do
    before { visit new_admin_category_path }

    it { expect(page).to have_title_and_content('New Category', 'New Category') }
  end

  describe 'show category page' do
    let(:category) { FactoryGirl.create(:category) }
    before { visit admin_category_path(category) }

    it { expect(page).to have_title_and_content(category.display_name, category.name) }
  end

  describe 'edit user page' do
    let(:category) { FactoryGirl.create(:category) }
    before { visit edit_admin_category_path(category) }

    it { expect(page).to have_title_and_content('Edit Category', 'Edit Category') }
  end
end