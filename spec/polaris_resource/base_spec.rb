require 'spec_helper'

describe PolarisResource::Base, "ActiveModel Lint" do

  let(:model_under_test) { PolarisResource::Base.new }
  it_behaves_like "ActiveModel"

end

describe PolarisResource::Base, "implements PolarisResource::Associations" do
  
  it "includes the PolarisResource::Associations module" do
    PolarisResource::Base.included_modules.should include(PolarisResource::Associations)
  end
  
end

describe PolarisResource::Base, "implements PolarisResource::Attributes" do
  
  it "includes the PolarisResource::Attributes module" do
    PolarisResource::Base.included_modules.should include(PolarisResource::Attributes)
  end
  
end

describe PolarisResource::Base, "implements PolarisResource::Conversion" do
  
  it "includes the PolarisResource::Finders module" do
    PolarisResource::Base.included_modules.should include(PolarisResource::Conversion)
  end
  
end

describe PolarisResource::Base, "implements PolarisResource::Finders" do
  
  it "includes the PolarisResource::Finders module" do
    PolarisResource::Base.included_modules.should include(PolarisResource::Finders)
  end
  
end

describe PolarisResource::Base, "implements PolarisResource::Introspection" do
  
  it "includes the PolarisResource::Finders module" do
    PolarisResource::Base.included_modules.should include(PolarisResource::Introspection)
  end
  
end

describe PolarisResource::Base, "implements PolarisResource::Persistence" do
  
  it "includes the PolarisResource::Persistence module" do
    PolarisResource::Base.included_modules.should include(PolarisResource::Persistence)
  end
  
end

describe PolarisResource::Base, "implements PolarisResource::ResponseParsing" do
  
  it "includes the PolarisResource::Finders module" do
    PolarisResource::Base.included_modules.should include(PolarisResource::ResponseParsing)
  end
  
end

describe PolarisResource::Base, ".initialize" do
  
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

describe PolarisResource::Base, "defines an id property by default" do
  
  it "defines setter and getter methods for the id property" do
    base = PolarisResource::Base.new(:id => 5)
    
    PolarisResource::Base.stub(:get).and_return(base)
    @base = PolarisResource::Base.find(1)
    @base.should respond_to(:id)
    @base.id.should eql(5)
  end
  
  it "creates an attribute entry for the id property" do
    PolarisResource::Base.new.attributes.should include(:id)
  end
  
end

describe PolarisResource::Base, ".==" do
  pending
end

describe PolarisResource::Base, "#base_class" do

  it "returns the current class" do
    Dog.base_class.should eql(Dog)
  end

end