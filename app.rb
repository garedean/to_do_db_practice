require 'sinatra'
require 'sinatra/reloader'
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pg')
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


post("/tasks") do
  description = params.fetch("description")
  task = Task.new(description)
  task.save()
  erb(:success)
end
