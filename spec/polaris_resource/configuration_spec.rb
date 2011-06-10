require 'spec_helper'

describe PolarisResource::Configuration, "#host" do
  
  context "when host has not been set" do
    
    before(:each) do
      PolarisResource::Configuration.host = nil
    end
    
    it "raises a ConfigurationError" do
      lambda {
        PolarisResource::Configuration.host
      }.should raise_error(PolarisResource::ConfigurationError, "The request HOST has not been set. Please set the host using PolarisResource::Configuration.host = 'http://www.example.com'")
    end
    
  end
  
  context "when host has been set" do
    
    before(:each) do
      PolarisResource::Configuration.host = "http://localhost:3000"
    end
  
    it "returns the host url string" do
      PolarisResource::Configuration.host.should eql("http://localhost:3000")
    end
    
  end
  
end

describe PolarisResource::Configuration, "#hydra" do
  
  context "when hydra has not been set" do
    
    before(:each) do
      PolarisResource::Configuration.hydra = nil
    end
    
    it "returns the shared Hydra instance from Typhoeus" do
      PolarisResource::Configuration.hydra.should eql(Typhoeus::Hydra.hydra)
    end
    
  end
  
  context "when hydra has been set" do
    
    before(:each) do
      @hydra = Typhoeus::Hydra.new
      PolarisResource::Configuration.hydra = @hydra
    end
    
    it "returns the specified Typhoeus Hydra instance" do
      PolarisResource::Configuration.hydra.should eql(@hydra)
    end
    
  end
  
end

describe PolarisResource::Configuration, "#logger" do
  pending
end

describe PolarisResource::Configuration, "#enable_stubbing!" do
  
  it "enables stubbing of resources" do
    PolarisResource::Configuration.enable_stubbing!
    PolarisResource::Configuration.should be_stubbing_enabled
  end
  
end

describe PolarisResource::Configuration, "#disable_stubbing!" do
  
  it "enables stubbing of resources" do
    PolarisResource::Configuration.disable_stubbing!
    PolarisResource::Configuration.should_not be_stubbing_enabled
  end
  
end

describe PolarisResource::Configuration, "#stubbing_enabled?" do
  pending
end

describe PolarisResource::Configuration, "#allow_net_connect" do
  
  it "disables all net connections through Typhoeus" do
    PolarisResource::Configuration.allow_net_connect = false
    lambda {
      Typhoeus::Request.get("http://localhost:3000")
    }.should raise_error(PolarisResource::NetConnectNotAllowedError)
  end
  
end

describe PolarisResource::Configuration, "#allow_net_connect?" do
  
  context "when net connect is allowed" do
    
    before(:each) do
      PolarisResource::Configuration.allow_net_connect = true
    end
    
    it "returns true" do
      PolarisResource::Configuration.should be_allow_net_connect
    end
    
  end
  
  context "when net connect is not allowed" do
    
    before(:each) do
      PolarisResource::Configuration.allow_net_connect = false
    end
    
    it "returns true" do
      PolarisResource::Configuration.should_not be_allow_net_connect
    end
    
  end
  
end