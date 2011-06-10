require 'spec_helper'

describe PolarisResource::Attributes, "#property" do
  
  it "defines setter and getter methods for the given property" do
    @book = Book.new
    @book.should respond_to(:title)
    @book.title = "Test Title"
    @book.title.should eql("Test Title")
  end
  
  it "creates an attribute entry for this property" do
    Book.new.attributes.should include(:title)
  end
  
end

describe PolarisResource::Attributes, "#default_attributes" do
  
  it "returns the default attributes has which will be applied as the attributes when a new object is instantiated" do
    Book.default_attributes.should eql(HashWithIndifferentAccess.new({ :id => nil, :title => nil, :author_id => nil }))
  end
  
end

describe PolarisResource::Attributes, "#typecast_attributes" do
  pending
end

describe PolarisResource::Attributes, "#attribute_defined?" do
  pending
end

describe PolarisResource::Attributes, ".attributes" do
  
  it "returns the attributes hash" do
    Book.new.attributes.should eql(HashWithIndifferentAccess.new({ :id => nil, :title => nil, :author_id => nil }))
  end
  
end

describe PolarisResource::Attributes, ".read_attribute_for_validation" do
  pending
end

describe PolarisResource::Attributes, ".typecast" do
  pending
end

describe PolarisResource::Attributes, ".attributes_without_id" do
  pending
end

describe PolarisResource::Attributes, ".update_attribute" do
  
  it "updates the attribute with the given value" do
    @book = Book.new(:title => "Horton Hears a Who")
    @book.title.should eql("Horton Hears a Who")
    @book.update_attribute(:title, "Red Fish, Blue Fish, One Fish, Two Fish")
    @book.title.should eql("Red Fish, Blue Fish, One Fish, Two Fish")
  end
  
end

describe PolarisResource::Attributes, ".merge_attributes" do
  
  it "updates each attribute with the given value" do
    @book = Book.new(:title => "Green Eggs and Ham")
    @book.id.should be_nil
    @book.title.should eql("Green Eggs and Ham")
    @book.send(:merge_attributes, { :title => "Red Fish, Blue Fish, One Fish, Two Fish", :id => 5 })
    @book.id.should eql(5)
    @book.title.should eql("Red Fish, Blue Fish, One Fish, Two Fish")
  end
  
end

describe PolarisResource::Attributes, "dirty tracking" do
  
  it "includes the ActiveModel::Validations module" do
    PolarisResource::Base.included_modules.should include(ActiveModel::Dirty)
  end
  
  it "tracks dirty state for property values" do
    @book = Book.new
    @book.should_not be_title_changed
    @book.title = "Dirty title"
    @book.should be_title_changed
  end
  
end

describe PolarisResource::Attributes, "validations" do
  
  it "includes the ActiveModel::Validations module" do
    PolarisResource::Base.included_modules.should include(ActiveModel::Validations)
  end
  
end