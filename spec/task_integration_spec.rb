require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application

describe('the task path') do
  it('Take form input, give that as an output to the user in a to-do list.') do
    visit('/')
    fill_in('description', :with => 'wash the zebra')
    click_button('submit')
    expect(page).to have_content('The task has been successfully submitted!')
  end
end
