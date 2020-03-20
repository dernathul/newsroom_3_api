require 'rails_helper'

feature 'List articles on index page' do
    context 'with articles in db' do
        before do
            create(:article, title: 'Breaking news')
            create(:article, title: 'Economy news')

            visit root_path
        end

        it 'displays first article title' do
            expect(page).to have_content 'Breaking news'
        end

        it 'displays second article' do
            expect(page).to have_content 'Economy news'
        end
    end
end