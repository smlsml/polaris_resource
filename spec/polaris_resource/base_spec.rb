require 'spec_helper'

describe PolarisResource::Base, "ActiveModel Lint" do

  let(:model_under_test) { PolarisResource::Base.new }
  it_behaves_like "ActiveModel"

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

describe PolarisResource::Base, "implements PolarisResource::Base::Associations" do
  
  it "includes the PolarisResource::Base::Associations module" do
    PolarisResource::Base.included_modules.should include(PolarisResource::Base::Associations)
  end
  
end

describe PolarisResource::Base, "implements PolarisResource::Base::Attributes" do
  
  it "includes the PolarisResource::Base::Attributes module" do
    PolarisResource::Base.included_modules.should include(PolarisResource::Base::Attributes)
  end
  
end

describe PolarisResource::Base, "implements PolarisResource::Base::Finders" do
  
  it "includes the PolarisResource::Base::Finders module" do
    PolarisResource::Base.included_modules.should include(PolarisResource::Base::Finders)
  end
  
end

describe PolarisResource::Base, "implements PolarisResource::Base::Persistence" do
  
  it "includes the PolarisResource::Base::Persistence module" do
    PolarisResource::Base.included_modules.should include(PolarisResource::Base::Persistence)
  end
  
end

describe PolarisResource::Base, "defines an id property by default" do
  
  it "defines setter and getter methods for the id property" do
    body = { :status => 200, :content => { :id => 5 } }
    response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
    
    PolarisResource::Request.stub(:get).and_return(response)
    @base = PolarisResource::Base.find(1)
    @base.should respond_to(:id)
    @base.id.should eql(5)
  end
  
  it "creates an attribute entry for the id property" do
    PolarisResource::Base.new.attributes.should include(:id)
  end
  
end

describe PolarisResource::Base, ".new_record?" do
  
  before(:each) do
    @attendee = Attendee.new
  end
  
  context "when the record is new" do
    
    it "returns true" do
      @attendee.should be_new_record
    end
    
  end
  
  context "when the record is not new" do
    
    before(:each) do
      response = PolarisResource::Response.new(:code => 201, :headers => "", :body => { :status => 201, :content => { :id => 1 } }.to_json, :time => 0.3)
      PolarisResource::Request.stub(:post).and_return(response)
      @attendee.save
    end
    
    it "returns false" do
      @attendee.should_not be_new_record
    end
    
  end
  
end

describe PolarisResource::Base, ".to_param" do
  
  context "when the id attribute is set" do
    
    before(:each) do
      body = { :status => 200, :content => { :id => 1 } }
      response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
      
      PolarisResource::Request.stub(:get).and_return(response)
      @base = PolarisResource::Base.find(1)
    end
    
    it "returns the id as a string" do
      @base.to_param.should eql("1")
    end
    
  end
  
  context "when the id attribute is set" do
    
    before(:each) do
      @base = PolarisResource::Base.new
    end
    
    it "returns the id as a string" do
      @base.to_param.should be_nil
    end
    
  end
  
end

describe PolarisResource::Base, "validations" do
  
  it "includes the ActiveModel::Validations module" do
    PolarisResource::Base.included_modules.should include(ActiveModel::Validations)
  end
  
end