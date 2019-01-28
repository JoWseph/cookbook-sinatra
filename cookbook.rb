require 'csv'
require_relative 'recipe'
# A cookbook de ouf
class Cookbook
  def initialize(csv_file)
    @database = csv_file
    @recipes = []
    reccup_existing
  end

  def reccup_existing
    CSV.foreach(@database) do |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_database(@recipes)
  end

  def all
    @recipes
  end

  def update_database(array)
    CSV.open(@database, 'wb') do |csv|
      array.each { |object| csv << [object.name, object.description] }
    end
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    update_database(@recipes)
  end

  def mark_as_done(index_recipe)
    @recipes[index_recipe].done = !@recipes[index_recipe].done
    update_database(@recipes)
  end

  def select_recipe(index)
    @recipes[index]
  end
end
