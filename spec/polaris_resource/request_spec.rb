require 'spec_helper'

describe PolarisResource::Request, "#get" do
  
  before(:each) do
    @response = Typhoeus::Response.new(:code => 200, :headers => "", :body => "", :time => 0.3)
    Typhoeus::Request.stub(:get).and_return(@response)
  end

  it "receives a uri, and makes a GET request at that uri using Typhoeus::Request" do
    Typhoeus::Request.should_receive(:get).with("http://localhost:3000/test", {}).and_return(@response)
    PolarisResource::Request.get("/test")
  end
  
  it "returns a PolarisResource::Response object containing the response" do
    response = PolarisResource::Request.get("/test")
    response.should be_a(PolarisResource::Response)
  end

end