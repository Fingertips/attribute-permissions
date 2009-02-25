require File.expand_path('../test_helper', __FILE__)

class FakeLogger
  def debug(*attrs)
  end
end

class Member < ActiveRecord::Base
  attr_protected :role
  
  def logger
    @logger ||= FakeLogger.new
  end
end

describe "A Member, with mass assignment methods" do
  cattr_accessor :valid_attributes
  self.valid_attributes = { :name => 'Manfred', :role => 'admin' }
  
  before do
    MassAssignmentTest::Initializer.setup_database
  end
  
  after do
    MassAssignmentTest::Initializer.teardown_database
  end
  
  it "should not allow mass assignment of protected attributes when initialized" do
    member = Member.new(valid_attributes)
    member.name.should == valid_attributes[:name]
    member.role.should.be.nil
  end
  
  it "should not allow mass assignment of protected attributes when updated" do
    member = Member.new
    member.update_attributes(:name => 'Manfred', :role => 'admin')
    member.name.should == valid_attributes[:name]
    member.role.should.be.nil
  end
  
  it "should allow explicit mass assignment of protected attributes when initialized" do
    member = Member.mass_assign(valid_attributes)
    member.name.should == valid_attributes[:name]
    member.role.should == valid_attributes[:role]
  end
  
  it "should allow explicit mass assignment of protected attributes when updated" do
    member = Member.new
    member.mass_assign(:name => 'Manfred', :role => 'admin')
    member.name.should == valid_attributes[:name]
    member.role.should == valid_attributes[:role]
  end
end