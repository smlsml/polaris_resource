require 'spec_helper'

class Automobile < Polaris::Resource::Base
  property :bhp
  property :wheels
  property :hybrid
  property :name
end

describe Polaris::Resource::Base, ".initialize" do
  
  context "when no attributes hash is supplied" do
    
    before(:each) do
      @auto = Automobile.new
    end
    
    it "has attributes that are set to nil" do
      @auto.attributes.should eql(HashWithIndifferentAccess.new({ :id => nil, :bhp => nil, :wheels => nil, :hybrid => nil, :name => nil }))
    end
    
  end
  
  context "when an attributes hash is supplied" do
    
    before(:each) do
      @auto = Automobile.new(
        :bhp    => 300,
        :wheels => 4,
        :hybrid => false,
        :name   => "Roadster"
      )
    end
    
    it "has attributes that are set to nil" do
      @auto.attributes.should eql(HashWithIndifferentAccess.new({ :id => nil, :bhp => 300, :wheels => 4, :hybrid => false, :name => "Roadster" }))
    end
    
  end
  
end

describe Polaris::Resource::Base, "implements Polaris::Resource::Base::Associations" do
  
  it "includes the Polaris::Resource::Base::Associations module" do
    Polaris::Resource::Base.included_modules.should include(Polaris::Resource::Base::Associations)
  end
  
end

describe Polaris::Resource::Base, "implements Polaris::Resource::Base::Attributes" do
  
  it "includes the Polaris::Resource::Base::Attributes module" do
    Polaris::Resource::Base.included_modules.should include(Polaris::Resource::Base::Attributes)
  end
  
end

describe Polaris::Resource::Base, "implements Polaris::Resource::Base::Finders" do
  
  it "includes the Polaris::Resource::Base::Finders module" do
    Polaris::Resource::Base.included_modules.should include(Polaris::Resource::Base::Finders)
  end
  
end

describe Polaris::Resource::Base, "implements Polaris::Resource::Base::Persistence" do
  
  it "includes the Polaris::Resource::Base::Persistence module" do
    Polaris::Resource::Base.included_modules.should include(Polaris::Resource::Base::Persistence)
  end
  
end

describe Polaris::Resource::Base, "defines an id property by default" do
  
  it "defines setter and getter methods for the id property" do
    @base = Polaris::Resource::Base.new
    @base.should respond_to(:id)
    @base.id = 5
    @base.id.should eql(5)
  end
  
  it "creates an attribute entry for the id property" do
    Polaris::Resource::Base.new.attributes.should include(:id)
  end
  
end

describe Polaris::Resource::Base, "#model_name" do
  
  it "returns the model name of the class as a string" do
    Polaris::Resource::Base.model_name.should eql("Base")
    Automobile.model_name.should eql("Automobile")
  end
  
end

describe Polaris::Resource::Base, ".new_record?" do
  
  before(:each) do
    @base = Polaris::Resource::Base.new
  end
  
  context "when the record is new" do
    
    it "returns true" do
      @base.should be_new_record
    end
    
  end
  
  context "when the record is not new" do
    
    before(:each) do
      response = Polaris::Resource::Response.new(:code => 201, :headers => "", :body => { :status => 200, :content => { :id => 1 } }.to_json, :time => 0.3)
      Polaris::Resource::Request.stub(:post).and_return(response)
      @base.save
    end
    
    it "returns false" do
      @base.should_not be_new_record
    end
    
  end
  
end

describe Polaris::Resource::Base, ".to_param" do
  
  context "when the id attribute is set" do
    
    before(:each) do
      @base = Polaris::Resource::Base.new
      @base.id = 1
    end
    
    it "returns the id as a string" do
      @base.to_param.should eql("1")
    end
    
  end
  
  context "when the id attribute is set" do
    
    before(:each) do
      @base = Polaris::Resource::Base.new
    end
    
    it "returns the id as a string" do
      @base.to_param.should be_nil
    end
    
  end
  
end