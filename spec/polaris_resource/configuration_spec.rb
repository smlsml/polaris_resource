require 'spec_helper'

describe Polaris::Resource::Configuration, ".host" do
  
  context "when host has not been set" do
    
    before(:each) do
      Polaris::Resource::Configuration.host = nil
    end
    
    it "raises a ConfigurationError" do
      lambda {
        Polaris::Resource::Configuration.host
      }.should raise_error(Polaris::Resource::ConfigurationError, "The request HOST has not been set. Please set the host using Polaris::Configuration.host = 'http://localhost:3000'")
    end
    
  end
  
  context "when host has been set" do
    
    before(:each) do
      Polaris::Resource::Configuration.host = "http://localhost:3000"
    end
  
    it "returns the host url string" do
      Polaris::Resource::Configuration.host.should eql("http://localhost:3000")
    end
    
  end
  
end

describe Polaris::Resource::Configuration, ".hydra" do
  
  context "when hydra has not been set" do
    
    before(:each) do
      Polaris::Resource::Configuration.hydra = nil
    end
    
    it "returns the shared Hydra instance from Typhoeus" do
      Polaris::Resource::Configuration.hydra.should eql(Typhoeus::Hydra.hydra)
    end
    
  end
  
  context "when hydra has been set" do
    
    before(:each) do
      @hydra = Typhoeus::Hydra.new
      Polaris::Resource::Configuration.hydra = @hydra
    end
    
    it "returns the specified Typhoeus Hydra instance" do
      Polaris::Resource::Configuration.hydra.should eql(@hydra)
    end
    
  end
  
end

describe Polaris::Resource::Configuration, ".enable_stubbing!" do
  
  it "enables stubbing of resources" do
    Polaris::Resource::Configuration.enable_stubbing!
    Polaris::Resource::Configuration.should be_stubbing_enabled
  end
  
end

describe Polaris::Resource::Configuration, ".disable_stubbing!" do
  
  it "enables stubbing of resources" do
    Polaris::Resource::Configuration.disable_stubbing!
    Polaris::Resource::Configuration.should_not be_stubbing_enabled
  end
  
end