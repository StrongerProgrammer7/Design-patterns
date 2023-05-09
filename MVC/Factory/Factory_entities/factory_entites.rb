class Entity
  def initialize
    # ...
  end
  
  def save
    # ...
  end
  
  def delete
    # ...
  end
end

class EntityList
  def initialize
    # ...
  end
  
  def add(entity)
    # ...
  end
  
  def remove(entity)
    # ...
  end
  
  def find(id)
    # ...
  end
end



class EntityFactory
  def self.actions(type_action)
    case type_action
    when :mysql
      @@type_action = Students_list_DB.new()
    when :json
      @@type_action = Students_list_json.new()
    when :yaml
      @@type_action = Students_list_yaml.new()
    when :txt
      @@type_action = Students_list_txt.new()
    else
      raise ArgumentError, "Invalid argument #{type_action}"
    end
  end

  def self.create_entity(type, *args)
    case type
    when :student
      print "Student.new(*args)"
    when :lab
      print "Lab_work.new(*args)"
    else
      raise "Invalid entity type: #{type}"
    end
  end
  
  def self.create_entity_list(type)
    case type
    when :student
      "Student_list.new(@@type_action)"
    when :labs
      "Lab_works_list.new(@@type_action)"
    else
      raise "Invalid entity type: #{type}"
    end
  end
end


