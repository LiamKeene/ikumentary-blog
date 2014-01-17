require 'spec_helper'

describe 'Category Pages' do

  subject { page }

  describe 'index' do
    let(:categories) { FactoryGirl.create_list(:category, 5) }
    before { visit admin_categories_path }

    it { should have_title(full_title('All Categories')) }
    it { should have_content('All Categories') }

    it 'should tabulate each category' do
      Category.all.each do |category|
        expect(page).to have_selector('td', text: category.display_name)
      end
    end
  end

  describe 'new category page' do
    before { visit new_admin_category_path }

    it { should have_title(full_title('New Category')) }
    it { should have_content('New Category') }
  end

  describe 'show category page' do
    let(:category) { FactoryGirl.create(:category) }
    before { visit admin_category_path(category) }

    it { should have_title(full_title(category.display_name)) }
    it { should have_content(category.name) }
  end

  describe 'edit user page' do
    let(:category) { FactoryGirl.create(:category) }
    before { visit edit_admin_category_path(category) }

    it { should have_title(full_title('Edit Category')) }
    it { should have_content('Edit Category') }
  end
end