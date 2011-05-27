require 'spec_helper'

class Post < Polaris::Resource::Base
  property :title, String
end

describe Polaris::Resource::Base::Attributes, "#property" do
  
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

describe Polaris::Resource::Base::Attributes, ".attributes" do
  
  it "returns the attributes hash" do
    Post.new.attributes.should eql({ :title => nil })
  end
  
end

describe Polaris::Resource::Base::Attributes, "#default_attributes" do
  
  it "returns the default attributes has which will be applied as the attributes when a new object is instantiated" do
    Post.default_attributes.should eql({ :title => nil })
  end
  
end