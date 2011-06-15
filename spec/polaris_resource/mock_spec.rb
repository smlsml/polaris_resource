require 'spec_helper'

class Fake
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

describe PolarisResource::Mock, ".initialize" do

  before(:each) do
    @mock = PolarisResource::Mock.new(Fake, 1, Fake.attributes)
  end

  it "sets the @mock_class variable to the class passed in as a string" do
    @mock.instance_variable_get('@mock_class').should eql("Fake")
  end

  it "creates a new instance of this mock class with the given id" do
    @mock.id.should eql(1)
  end

  it "sets the @attributes variable using the attributes and id passed in" do
    @mock.instance_variable_get('@attributes').should eql(HashWithIndifferentAccess.new(Fake.attributes.merge({ :id => 1 })))
  end

  it "creates attr_accessors for each attribute" do
    @mock.instance_variable_get('@attributes').keys.each do |key|
      @mock.should respond_to(key)
      @mock.should respond_to("#{key}=")
    end
  end

  it "stubs the find method by stubbing the find url at '/:mock_class/:id'" do
    body = {
      :status  => 200,
      :content => Fake.attributes.merge({ :id => 1 })
    }.to_json
    response = Typhoeus::Response.new(:code => 200, :headers => "", :body => body, :time => 0.3)
    @test_stub = Typhoeus::HydraMock.new("#{PolarisResource::Configuration.host}/fakes/1", :get)
    @test_stub.and_return(response)
    @stub = PolarisResource::Configuration.hydra.stubs.find do |stub|
      stub.url == @test_stub.url
    end
    @stub.should be_matches(Typhoeus::Request.new("#{PolarisResource::Configuration.host}/fakes/1", :method => :get))
    Yajl::Parser.parse(@stub.response.body).should eql(Yajl::Parser.parse(@test_stub.response.body))
  end

  context "when given a specific status code" do

    before(:each) do
      PolarisResource::Mock.clear!
      PolarisResource::Mock.new(Fake, 1, Fake.attributes, :status => 500)
    end

    it "returns a response with the given status code" do
      PolarisResource::Configuration.hydra.should eql(Typhoeus::Hydra.hydra)
      response = Typhoeus::Request.get("#{PolarisResource::Configuration.host}/fakes/1")
      response.code.should eql(500)
    end

  end

end

describe PolarisResource::Mock, ".id" do
  
  before(:each) do
    @mock = PolarisResource::Mock.new(Fake, 1, Fake.attributes)
  end
  
  it "returns the id attribute" do
    @mock.id.should eql(1)
  end
  
end

describe PolarisResource::Mock, ".status" do
  
  context "when a status code has not been set" do
    
    before(:each) do
      @mock = PolarisResource::Mock.new(Fake, 1, Fake.attributes)
    end
    
    it "returns 200" do
      @mock.status.should eql(200)
    end
    
  end
  
  context "when a status code has been set to 500" do
    
    before(:each) do
      @mock = PolarisResource::Mock.new(Fake, 1, Fake.attributes, :status => 500)
    end
    
    it "returns 500" do
      @mock.status.should eql(500)
    end
    
  end
  
end

describe PolarisResource::Mock, "#mock" do

  it "returns a new instance of Mock" do
    PolarisResource::Mock.mock(Fake, 1).should be_a(PolarisResource::Mock)
  end

end

describe PolarisResource::Mock, "#clear!" do

  it "clears all mock requests from Typhoeus" do
    PolarisResource::Mock.new(Fake, 1, Fake.attributes)
    PolarisResource::Mock.new(Fake, 2, Fake.attributes)
    PolarisResource::Mock.new(Fake, 3, Fake.attributes)
    PolarisResource::Configuration.hydra.stubs.should have(3).stubs
    PolarisResource::Mock.clear!
    PolarisResource::Configuration.hydra.stubs.should be_empty
  end

end