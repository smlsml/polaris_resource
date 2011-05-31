require 'spec_helper'

class State < PolarisResource::Base
  property :name
  property :capital
  property :motto
end

describe PolarisResource::Base::Persistence, "#save" do
  
  context "when the instance is a new record" do
    
    before(:each) do
      @attributes = HashWithIndifferentAccess.new({
        :name    => "California",
        :capital => "Sacramento",
        :motto   => "Eureka!"
      })
      @california = State.new(@attributes)
      body = {
        :status  => 200,
        :content => @attributes.merge(:id => 1)
      }
      @response = PolarisResource::Response.new(:code => 201, :headers => "", :body => body.to_json, :time => 0.3)
      PolarisResource::Request.stub(:post).and_return(@response)
    end
    
    it "makes a POST request to the external service" do
      PolarisResource::Request.should_receive(:post).with("/states", @california.attributes_without_id).and_return(@response)
      @california.save
    end
    
    it "receives a response with the attributes for this instance" do
      @california.should_receive(:merge_attributes).with(@attributes.merge(:id => 1))
      @california.save
    end
    
    it "updates the attributes to match those returned in the response" do
      @california.id.should be_nil
      @california.save
      @california.id.should eql(1)
    end
    
    it "marks the instance as not new" do
      @california.should be_new_record
      @california.save
      @california.should_not be_new_record
    end
    
    it "sets the errors hash based on the response" do
      @california.save
      @california.errors.should be_empty
    end
    
    it "sets the valid? flag based on the response" do
      @california.save
      @california.should be_valid
    end
    
  end
  
  context "when the instance is not a new record" do
    
    before(:each) do
      @attributes = HashWithIndifferentAccess.new({
        :name    => "California",
        :capital => "Sacramento",
        :motto   => "Eureka!"
      })
      body = {
        :status  => 200,
        :content => @attributes.merge(:id => 1)
      }
      @state = State.new(@attributes)
      response = PolarisResource::Response.new(:code => 201, :headers => "", :body => body.to_json, :time => 0.3)
      PolarisResource::Request.stub(:post).and_return(response)
      @state.save
      
      @state.name    = "Oregon"
      @state.capital = "Salem"
      @state.motto   = "She flies with her own wings"
      
      body = {
        :status  => 200,
        :content => @state.attributes
      }
      @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
      PolarisResource::Request.stub(:put).and_return(@response)
    end
    
    it "makes a PUT request to the external service" do
      PolarisResource::Request.should_receive(:put).with("/states/1", @state.attributes_without_id).and_return(@response)
      @state.save
    end
    
    it "receives a response with the attributes for this instance" do
      attributes = { :id => 1, :name => "Oregon", :capital => "Salem", :motto => "She flies with her own wings" }
      @state.should_receive(:merge_attributes).with(HashWithIndifferentAccess.new(attributes))
      @state.save
    end
    
    it "sets the errors hash based on the response" do
      @state.save
      @state.errors.should be_empty
    end
    
    it "sets the valid? flag based on the response" do
      @state.save
      @state.should be_valid
    end
    
  end
  
end

describe PolarisResource::Base::Persistence, "#update_attributes" do
  
  before(:each) do
    @attributes = HashWithIndifferentAccess.new({
      :name    => "California",
      :capital => "Sacramento",
      :motto   => "Eureka!"
    })
    body = {
      :status  => 200,
      :content => @attributes.merge(:id => 1)
    }
    @state = State.new(@attributes)
    response = PolarisResource::Response.new(:code => 201, :headers => "", :body => body.to_json, :time => 0.3)
    PolarisResource::Request.stub(:post).and_return(response)
    @state.save
    
    body = {
      :status  => 200,
      :content => { :id => 1, :name => "Oregon", :capital => "Salem", :motto => "She flies with her own wings"}
    }
    @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
    PolarisResource::Request.stub(:put).and_return(@response)
  end
  
  it "sets the attributes to their new values" do
    @state.update_attributes(:name => "Oregon", :capital => "Salem", :motto => "She flies with her own wings")
    @state.name.should eql("Oregon")
    @state.capital.should eql("Salem")
    @state.motto.should eql("She flies with her own wings")
  end
  
  it "calls .save on the record" do
    @state.should_receive(:save)
    @state.update_attributes(:name => "Oregon", :capital => "Salem", :motto => "She flies with her own wings")
  end
  
end