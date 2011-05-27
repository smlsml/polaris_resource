require 'spec_helper'

# DUMMY class for testing purposes
class Dummy
  def self.attributes
    {
      :string   => "Test",
      :boolean  => true,
      :datetime => 'May 14, 2011, 5:00PM',
      :time     => 'May 14, 2011, 5:00PM',
      :date     => 'May 14, 2011',
      :array    => [1,2,3],
      :hash     => { :one => 1, :two => "two" }
    }
  end
end

describe Polaris::Resource::Mock, "#mock" do

  it "returns a new instance of Mock" do
    Polaris::Resource::Mock.mock(Dummy, 1).should be_a(Polaris::Resource::Mock)
  end

end

describe Polaris::Resource::Mock, ".initialize" do

  before(:each) do
    @mock = Polaris::Resource::Mock.new(Dummy, 1, Dummy.attributes)
  end

  it "sets the @mock_class variable to the class passed in as a string" do
    @mock.instance_variable_get('@mock_class').should eql("Dummy")
  end

  it "creates a new instance of this mock class with the given id" do
    @mock.id.should eql(1)
  end

  it "sets the @attributes variable using the attributes and id passed in" do
    @mock.instance_variable_get('@attributes').should eql(HashWithIndifferentAccess.new(Dummy.attributes.merge({ :id => 1 })))
  end

  it "creates attr_accessors for each attribute" do
    @mock.instance_variable_get('@attributes').keys.each do |key|
      @mock.should respond_to(key)
      @mock.should respond_to("#{key}=")
    end
  end

  it "stubs the find method by stubbing the find url at '/:mock_class/:id'" do
    body = Dummy.attributes.merge({ :id => 1 }).to_json
    response = Typhoeus::Response.new(:code => 200, :headers => "", :body => body, :time => 0.3)
    @test_stub = Typhoeus::HydraMock.new("#{Polaris::Resource::Configuration.host}/dummies/1", :get)
    @test_stub.and_return(response)
    @stub = Polaris::Resource::Configuration.hydra.stubs.find do |stub|
      stub.url == @test_stub.url
    end
    @stub.should be_matches(Typhoeus::Request.new("#{Polaris::Resource::Configuration.host}/dummies/1", :method => :get))
    Yajl::Parser.parse(@stub.response.body).should eql(Yajl::Parser.parse(@test_stub.response.body))
  end

  context "when given a specific status code" do

    before(:each) do
      Polaris::Resource::Mock.clear!
      @mock = Polaris::Resource::Mock.new(Dummy, 1, Dummy.attributes, :status => 500)
    end

    it "returns a response with the given status code" do
      response = Typhoeus::Request.get("#{Polaris::Resource::Configuration.host}/dummies/1")
      response.code.should eql(500)
    end

  end

end

describe Polaris::Resource::Mock, "#clear!" do

  it "clears all mock requests from Typhoeus" do
    Polaris::Resource::Mock.new(Dummy, 1, Dummy.attributes)
    Polaris::Resource::Mock.new(Dummy, 2, Dummy.attributes)
    Polaris::Resource::Mock.new(Dummy, 3, Dummy.attributes)
    Polaris::Resource::Configuration.hydra.stubs.should have(3).stubs
    Polaris::Resource::Mock.clear!
    Polaris::Resource::Configuration.hydra.stubs.should be_empty
  end

end

describe Polaris::Resource::Mock, "#matches?" do

  context "when there is a mock that matches this request" do

    before(:each) do
      Polaris::Resource::Mock.new(Dummy, 1, Dummy.attributes)
    end

    it "returns true" do
      Polaris::Resource::Mock.matches?(Typhoeus::Request.new("#{Polaris::Resource::Configuration.host}/dummies/1", :method => :get)).should be_true
    end

  end

  context "when there is no mock that matches this request" do

    it "returns false" do
      Polaris::Resource::Mock.matches?(Typhoeus::Request.new("#{Polaris::Resource::Configuration.host}/dummies/1", :method => :get)).should be_false
    end

  end

end

describe Polaris::Resource::Mock, ".status" do
  
  context "when a status code has not been set" do
    
    before(:each) do
      @mock = Polaris::Resource::Mock.new(Dummy, 1, Dummy.attributes)
    end
    
    it "returns 200" do
      @mock.status.should eql(200)
    end
    
  end
  
  context "when a status code has been set to 500" do
    
    before(:each) do
      @mock = Polaris::Resource::Mock.new(Dummy, 1, Dummy.attributes, :status => 500)
    end
    
    it "returns 500" do
      @mock.status.should eql(500)
    end
    
  end
  
end