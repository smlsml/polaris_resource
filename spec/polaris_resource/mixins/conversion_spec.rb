require 'spec_helper'

describe PolarisResource::Conversion, ".to_model" do
  
  before(:each) do
    @dog = Dog.new
  end

  it "returns this object" do
    @dog.to_model.should eql(@dog)
  end

end

describe PolarisResource::Conversion, ".to_param" do
  
  context "when the id attribute is set" do
    
    before(:each) do
      PolarisResource::Base.stub(:get).and_return(PolarisResource::Base.new(:id => 1))
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

describe PolarisResource::Conversion, ".to_key" do
  
  context "when the object is a new record" do
  
    before(:each) do
      @dog = Dog.new(:name => "Daisy", :breed => "English Bulldog", :age => 2)
    end
  
    it "returns nil" do
      @dog.to_key.should be_nil
    end
    
  end
  
  context "when the object is persisted" do

    before(:each) do
      Dog.stub(:get).and_return(Dog.new(:id => 1, :name => "Daisy", :breed => "English Bulldog", :age => 2))
      @dog = Dog.find(1)
    end

    it "returns the attribute keys of the object" do
      @keys = @dog.to_key
      @keys.should have(4).keys
      @keys.should include('id')
      @keys.should include('name')
      @keys.should include('breed')
      @keys.should include('age')
    end
    
  end
  
end