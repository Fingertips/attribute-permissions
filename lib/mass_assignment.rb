# Implements the mass_assign instance and class methods. Include in your class for easy mass assignments.
#
#   class Book
#     attr_accessor :title, :author
#     include MassAssignment
#   end
#
#   book = Book.mass_assign(:title => 'The Little Red Book', :author => 'Jenny from the Block')
#   book.title #=> 'The Little Red Book'
module MassAssignment
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  module ClassMethods
    # Intializes a new object and assigns the attribute hash to the appropriate
    # attribute writers using the mass_assign method on the newly created object.
    #
    # Example:
    #
    #   User.mass_assign(:username => 'Manfred', :password => 'very secret')
    #
    # Instead of:
    #
    #   user = User.new
    #   user.mass_assign(:username => 'Manfred', :password => 'very secret')
    def mass_assign(attributes)
      object = new
      object.mass_assign(attributes)
      object
    end
  end
  
  # Sends all the attributes in the attribute hash to the appropriate attribute writer.
  # This is a way to circumvent the normal attribute protection on Rails models.
  #
  # Example:
  #
  #   user.mass_assign(:username => 'Manfred', :password => 'very secret')
  #
  # Instead of:
  #
  #   user.username = 'Manfred'
  #   user.password = 'very secret'
  def mass_assign(attributes)
    send(:attributes=, attributes, false)
  end
end

class ActiveRecord::Base
  include MassAssignment
end