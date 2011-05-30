require 'spec_helper'

class Meeting < PolarisResource::Base
  belongs_to :conference
  has_many   :attendees
  has_one    :speaker
end

describe PolarisResource::Base::Associations, "#belongs_to" do
  
  it "creates a property for this class matching association name, e.g. belong_to :author # => :author_id" do
    Meeting.new.attributes.should include('conference_id')
  end
  
  it "defines a getter method" do
    Meeting.new.should respond_to(:conference)
  end

  it "defines a private method called '_conference_uri'" do
    Meeting.new.private_methods.should include('_conference_uri')
  end
  
  context "when the belongs_to association is fulfilled by is contracted 'association_id' attribute" do
    
    before(:each) do
      @meeting = Meeting.new
      @meeting.conference_id = 1
    end
    
    it "returns a string matching '/conferences/1'" do
      @meeting.send(:_conference_uri).should eql('/conferences/1')
    end
    
  end
  
  context "when the belongs_to association is fulfilled by is contracted 'association_id' attribute" do
    
    before(:each) do
      @meeting = Meeting.new
      @meeting.conference_id = nil
    end
    
    it "returns nil" do
      @meeting.send(:_conference_uri).should be_nil
    end
    
  end
  
end

describe PolarisResource::Base::Associations, "#has_many" do
  
  it "creates a getter method" do
    Meeting.new.should respond_to(:attendees)
  end
  
  it "defines a private method called '_attendees_uri'" do
    Meeting.new.private_methods.should include('_attendees_uri')
  end
  
  context "when the record has no id" do
    
    before(:each) do
      @meeting = Meeting.new
    end
    
    it "returns nil" do
      @meeting.send(:_attendees_uri).should be_nil
    end
    
  end
  
  context "when the record has an id" do
    
    before(:each) do
      @meeting = Meeting.new
      @meeting.id = 1
    end
    
    it "returns a string matching '/meetings/1/attendees'" do
      @meeting.send(:_attendees_uri).should eql('/meetings/1/attendees')
    end
    
  end
  
end

describe PolarisResource::Base::Associations, "#has_one" do
  
  it "creates a getter method" do
    Meeting.new.should respond_to(:speaker)
  end
  
  it "defines a private method called '_speaker_uri'" do
    Meeting.new.private_methods.should include('_speaker_uri')
  end
  
  context "when the record has no id" do
    
    before(:each) do
      @meeting = Meeting.new
    end
    
    it "returns nil" do
      @meeting.send(:_speaker_uri).should be_nil
    end
    
  end
  
  context "when the record has an id" do
    
    before(:each) do
      @meeting = Meeting.new
      @meeting.id = 1
    end
    
    it "returns a string matching '/meetings/1/attendees'" do
      @meeting.send(:_speaker_uri).should eql('/meetings/1/speaker')
    end
    
  end
  
end