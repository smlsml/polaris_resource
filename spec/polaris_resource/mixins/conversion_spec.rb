require 'spec_helper'

describe PolarisResource::Conversion, ".to_model" do
  pending
end

describe PolarisResource::Conversion, ".to_param" do
  
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

describe PolarisResource::Conversion, ".to_key" do
  pending
end