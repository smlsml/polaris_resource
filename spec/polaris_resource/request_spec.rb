require 'spec_helper'

describe PolarisResource::Request, "#get" do
  
  before(:each) do
    @response = Typhoeus::Response.new(:code => 200, :headers => "", :body => "", :time => 0.3)
    Typhoeus::Request.stub(:new).and_return(@response)
  end

  it "receives a uri, and makes a GET request at that uri using Typhoeus::Request" do
    Typhoeus::Request.should_receive(:new).with("http://localhost:3000/test", { :method => :get }).and_return(@response)
    PolarisResource::Request.new("/test", :method => :get)
  end
  
  it "returns a PolarisResource::Response object containing the response" do
    request = PolarisResource::Request.new("/test", :method => :get)
    response.should be_a(PolarisResource::Response)
  end

end