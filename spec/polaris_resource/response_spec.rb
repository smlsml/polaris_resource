require 'spec_helper'

describe PolarisResource::Response, ".cached?" do

  context "when the response is marked as cached" do
    
    before(:each) do
      @response = PolarisResource::Response.new({ :code => 200, :headers => "", :body => "", :time => 0.3 }, true)
    end
    
    it "returns true" do
      @response.should be_cached
    end
    
  end
  
  context "when the response is marked as not cached" do
    
    before(:each) do
      @response = PolarisResource::Response.new({ :code => 200, :headers => "", :body => "", :time => 0.3 }, false)
    end

    it "returns false" do
      @response.should_not be_cached
    end

  end
  
  context "when the response is not marked as cached or otherwise" do
    
    before(:each) do
      @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => "", :time => 0.3)
    end

    it "returns false" do
      @response.should_not be_cached
    end

  end

end

describe PolarisResource::Response, ".respond_to?" do
  
  before(:each) do
    @typhoeus_response = Typhoeus::Response.new(:code => 200, :headers => "", :body => "", :time => 0.3)
    @response          = PolarisResource::Response.new(@typhoeus_response)
  end
  
  it "responds to all methods defined on itself" do
    @response.methods.reject { |method| method == :respond_to? }.each do |method|
      @response.should respond_to(method)
    end
  end
  
  it "responds to all methods defined on the Typhoeus::Response object it wraps" do
    @typhoeus_response.methods.each do |method|
      @response.should respond_to(method)
    end
  end
  
end

describe PolarisResource::Response, ".method_missing" do

  it "wraps a Typhoeus::Response object" do
    @response = PolarisResource::Response.new
    Typhoeus::Response.new.methods.each do |method|
      @response.should respond_to(method.to_sym)
    end
  end

end