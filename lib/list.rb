class List

  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    returned_lists.each() do |list|
      name = list.fetch('type')
      id = list.fetch('id').to_i()
      lists.push(List.new(name: name, id: id))
    end
    lists
  end

  def save
    result = DB.exec("INSERT INTO lists (type) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_list)
    self.name().==(another_list.name()).&(self.id().==(another_list.id()))
  end

  def self.find(target_id)
    list_match = nil

    all.each do |list|
      list_match = list if list.id == target_id
    end
    list_match
  end

  def tasks
    tasks = []
    returned_tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{@id};")
    returned_tasks.each do |task|
      description = task['description']
      list_id     = task['list_id'].to_i
      tasks << Task.new(description: description, list_id: list_id)
    end
    tasks
  end
end
