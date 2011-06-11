require 'spec_helper'

describe PolarisResource::Associations::Association, ".id" do
  
  before(:each) do
    meeting =  Meeting.new(:title => "Rails Development").attributes.merge(:id => 5)
    body = {
      :status  => 200,
      :content => meeting
    }
    response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
    PolarisResource::Request.stub(:get).and_return(response)
  end
  
  it "calls the loaded target and retrieves it's id" do
    @speaker = Speaker.new(:meeting_id => 5)
    @speaker.meeting.id.should eql(5)
  end
  
end

describe PolarisResource::Associations::Association, ".nil?" do
  
  context "when the loaded target is nil" do
    
    before(:each) do
      @association = PolarisResource::Associations::Association.new(Speaker.new, :meeting)
      @association.stub(:load_target!).and_return(nil)
    end
    
    it "returns true" do
      @association.should be_nil
    end
    
  end
  
  context "when the loaded target is not nil" do
    
    before(:each) do
      @association = PolarisResource::Associations::Association.new(Speaker.new, :meeting)
      @association.stub(:load_target!).and_return(Meeting.new)
    end
    
    it "returns false" do
      @association.should_not be_nil
    end
    
  end
  
end

describe PolarisResource::Associations::Association, ".loaded_target" do
  
  before(:each) do
    meeting =  Meeting.new(:title => "Rails Development").attributes.merge(:id => 5)
    body = {
      :status  => 200,
      :content => meeting
    }
    @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
  end
  
  it "loads target only once" do
    PolarisResource::Request.should_receive(:get).once.and_return(@response)
    @speaker = Speaker.new(:meeting_id => 5)
    @speaker.meeting.id
    @speaker.meeting.id
  end
  
end

describe PolarisResource::Associations::Association, ".method_missing" do

  before(:each) do
    meeting =  Meeting.new(:title => "Rails Development").attributes.merge(:id => 5)
    body = {
      :status  => 200,
      :content => meeting
    }
    @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
    PolarisResource::Request.stub(:get).and_return(@response)
  end
  
  it "calls the loaded target and tries the method on the target" do
    @speaker = Speaker.new(:meeting_id => 5)
    @speaker.meeting.title
  end

end