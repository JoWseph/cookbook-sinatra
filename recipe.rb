# A recipe de ouf
class Recipe
  attr_accessor :name, :description, :done
  def initialize(name, description, _done = false)
    @name = name
    @description = description
    @done = false
  end
end
