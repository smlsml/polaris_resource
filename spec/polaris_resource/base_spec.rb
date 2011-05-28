require 'spec_helper'

class Automobile < Polaris::Resource::Base
end

describe Polaris::Resource::Base do
  pending
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