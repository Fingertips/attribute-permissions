module MassAssignmentTest
  module Initializer
    PLUGIN_ROOT = File.expand_path('../../', __FILE__)
    
    def self.load_dependencies
      require 'rubygems'
      
      require 'active_support'
      require 'active_record'
      
      require 'rubygems' rescue LoadError
      
      require 'test/spec'
      require 'mocha'
      
      require File.join(PLUGIN_ROOT, 'init')
    end
    
    def self.configure_database
      ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
      ActiveRecord::Migration.verbose = false
    end
    
    def self.setup_database
      ActiveRecord::Schema.define(:version => 1) do
        create_table :members do |t|
          t.column :name, :string
          t.column :role, :string
          t.timestamps
        end
      end
    end
    
    def self.teardown_database
      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.drop_table(table)
      end
    end
    
    def self.start
      load_dependencies
      configure_database
    end
  end
end

MassAssignmentTest::Initializer.start