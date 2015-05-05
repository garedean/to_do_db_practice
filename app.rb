require 'sinatra'
require 'sinatra/reloader'
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pg')
require('pry')
DB = PG.connect(dbname: 'to_do')


get('/') do
  erb(:index)
end

get('/lists/new') do
  erb(:new_list)
end

get('/tasks/new') do
  erb(:new_task)
end

get('/lists') do
  @lists = List.all()
  erb(:lists)
end

get('/lists/:id') do
  @list = List.find(params.fetch('id').to_i())
  erb(:list)
end

post('/lists') do
  name = params.fetch('name')
  list = List.new(name: name, id: nil)
  list.save()

  erb(:success)
end

post("/tasks") do
  description = params.fetch("description")
  list_id     = params.fetch("list_id")
  list        = List.find(list_id.to_i)

  task = Task.new(description: description, list_id: list_id)
  task.save()
  redirect to("/lists/#{list.id}")
end
