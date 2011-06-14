require 'spec_helper'

describe PolarisResource::Associations, "#belongs_to" do
  
  it "creates a property for this class matching association name, e.g. belong_to :author # => :author_id" do
    Meeting.new.attributes.should include('conference_id')
  end
  
  it "defines a getter method" do
    Meeting.new.should respond_to(:conference)
  end
  
  context "when the belongs_to association is fulfilled by its contracted 'association_id' attribute" do
    
    before(:each) do
      meeting = Meeting.new(:id => 1, :conference_id => 2)
      meetings = [meeting]
      conference = Conference.new(:id => 2)
      
      Meeting.stub(:get) do |uri, params|
        case uri
        when '/meetings/1'
          meeting
        when '/conferences/2/meetings'
          meetings
        end
      end
      Conference.stub(:get).and_return(conference)
      
      @meeting = Meeting.find(1)
    end
    
    it "returns the belongs_to association object" do
      @conference = @meeting.conference
      @conference.should be_a(Conference)
      @conference.id.should eql(2)
      @conference.meetings.should include(@meeting)
    end
    
  end
  
  context "when the belongs_to association is fulfilled by its contracted 'association_id' attribute" do
    
    before(:each) do
      @meeting = Meeting.new
      @meeting.conference_id = nil
    end
    
    it "returns nil" do
      @meeting.conference.should be_nil
    end
    
  end
  
end

describe PolarisResource::Associations, "#has_many" do
  
  it "creates a getter method" do
    Meeting.new.should respond_to(:attendees)
  end
  
  context "when the record has no id" do
    
    before(:each) do
      @meeting = Meeting.new
    end
    
    it "returns an empty array" do
      @attendees = @meeting.attendees
      @attendees.should be_an(Array)
      @attendees.should be_empty
    end
    
  end
  
  context "when the record has an id" do
    
    before(:each) do
      meeting = Meeting.new(:id => 1, :conference_id => 2)
      attendees = [Attendee.new(:id => 2), Attendee.new(:id => 5)]
      
      Meeting.stub(:get).and_return(meeting)
      Attendee.stub(:get).and_return(attendees)
      
      @meeting = Meeting.find(1)
    end
    
    it "returns the associated objects" do
      @attendees = @meeting.attendees
      @attendees.should be_an(Array)
      @attendees.should have(2).attendees
      @attendees.each do |attendee|
        attendee.should be_a(Attendee)
      end
    end
    
  end
  
end

describe PolarisResource::Associations, "#has_one" do
  
  it "creates a getter method" do
    Meeting.new.should respond_to(:speaker)
  end
  
  context "when the record has no id" do
    
    before(:each) do
      @meeting = Meeting.new
    end
    
    it "returns nil" do
      @meeting.speaker.should be_nil
    end
    
  end
  
  context "when the record has an id" do
    
    before(:each) do
      meeting = Meeting.new(:id => 1, :conference_id => 2)
      speaker = Speaker.new(:id => 5, :meeting_id => 1)
      
      Meeting.stub(:get).and_return(meeting)
      Speaker.stub(:get).and_return(speaker)
      
      @meeting = Meeting.find(1)
    end
    
    it "returns the association object" do
      @speaker = @meeting.speaker
      @speaker.should be_a(Speaker)
      @speaker.id.should eql(5)
      @speaker.meeting.should == @meeting
    end
    
  end
  
end