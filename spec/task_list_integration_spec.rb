require 'capybara/rspec'
require './app.rb'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the home page path', type: 'feature') do
  it('will have link to create a new list') do
    visit('/')
    click_link('Create a new task list')
    expect(page).to have_content('Create a new task list!')
  end
end
