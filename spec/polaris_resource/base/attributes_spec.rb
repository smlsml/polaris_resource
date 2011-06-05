require 'spec_helper'

describe PolarisResource::Base::Attributes, "#property" do
  
  it "defines setter and getter methods for the given property" do
    @post = Post.new
    @post.should respond_to(:title)
    @post.title = "Test Title"
    @post.title.should eql("Test Title")
  end
  
  it "creates an attribute entry for this property" do
    Post.new.attributes.should include(:title)
  end
  
end

describe PolarisResource::Base::Attributes, ".attributes" do
  
  it "returns the attributes hash" do
    Post.new.attributes.should eql(HashWithIndifferentAccess.new({ :id => nil, :title => nil }))
  end
  
end

describe PolarisResource::Base::Attributes, "#default_attributes" do
  
  it "returns the default attributes has which will be applied as the attributes when a new object is instantiated" do
    Post.default_attributes.should eql(HashWithIndifferentAccess.new({ :id => nil, :title => nil }))
  end
  
end

describe PolarisResource::Base::Attributes, ".update_attribute" do
  
  it "updates the attribute with the given value" do
    @post = Post.new(:title => "Horton Hears a Who")
    @post.title.should eql("Horton Hears a Who")
    @post.update_attribute(:title, "Red Fish, Blue Fish, One Fish, Two Fish")
    @post.title.should eql("Red Fish, Blue Fish, One Fish, Two Fish")
  end
  
end

describe PolarisResource::Base::Attributes, ".merge_attributes" do
  
  it "updates each attribute with the given value" do
    @post = Post.new(:title => "Green Eggs and Ham")
    @post.id.should be_nil
    @post.title.should eql("Green Eggs and Ham")
    @post.merge_attributes(:title => "Red Fish, Blue Fish, One Fish, Two Fish", :id => 5)
    @post.id.should eql(5)
    @post.title.should eql("Red Fish, Blue Fish, One Fish, Two Fish")
  end
  
end

describe PolarisResource::Base::Attributes, "dirty tracking" do
  
  it "tracks dirty state for property values" do
    @post = Post.new
    @post.should_not be_title_changed
    @post.title = "Dirty title"
    @post.should be_title_changed
  end
  
end