require 'capybara/rspec'
require './app.rb'
require 'spec_helper'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the home page path', type: :feature) do
  # it('will have link to create a new list') do
  #   visit('/')
  #   click_link('Create a new task list')
  #   expect(page).to have_content('Create a new task list!')
  # end
  #
  # it('will have a link to view all of my lists') do
  #   visit('/')
  #   click_link('See all current task lists')
  #   expect(page).to have_content('Here is your current task lists!')
  # end
  #
  it('allows new lists to be created on the page') do
    visit('/')
    fill_in('name', with: "Totally new list")
    click_button('Send')
    expect(page).to have_content('Totally new list')
  end

  it('shows all lists') do
    list = List.new(name: 'List 1', id: nil)
    list.save
    visit('/')
    expect(page).to have_content('List 1')
  end
end

describe('create a list path', type: :feature) do
  it('will submit form and show success page') do
    visit('/')
    click_link('Create a new task list')
    fill_in('name', with: 'school')
    click_button('Send')
    expect(page).to have_content('The task list has been successfully submitted!')
  end
end

describe('lists path', type: :feature) do
  it('will display all lists') do
    list = List.new(name: 'Work List', id: nil)
    list.save
    visit('/lists')
    expect(page).to have_content('Work List')
  end
end

describe('individual list path', type: :feature) do
  it('show information for individual list') do
    list = List.new(name: 'Grocery List', id: nil)
    list.save
    visit("/lists/#{list.id}")
    expect(page).to have_content('Grocery List')
  end
end

describe('add task path', type: :feature) do
  it('will create a new task') do
    list = List.new(name: 'School List', id: nil)
    list.save
    visit("/lists/#{list.id}")
    fill_in('description', with: "get pens and paper")
    click_button('Send')
    expect(page).to have_content("get pens and paper")
  end
end
