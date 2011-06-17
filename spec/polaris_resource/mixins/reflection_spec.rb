require 'spec_helper'

describe PolarisResource::Reflection, "ClassMethods" do
  context "when the resource has a belongs_to association" do
    before(:each) do
      @meeting = Meeting.new(:id => 1, :conference_id=>2, :conference => {:id=>2, :name=>'A conference', :notes=>'There be notes'})
    end

    it "returns the association with the correct type and all nested attributes" do
      @conference = @meeting.conference
      @conference.should be_a(Conference)
      @conference.id.should eql(2)
      @conference.name.should eql('A conference')
      @conference.notes.should eql('There be notes')
    end
    
    it "still allows setting the association the old-fashioned way" do
      @conference = Conference.new(:id => 3, :name=>'Different')
      @meeting.conference = @conference
      @meeting.conference_id.should eql(3)
      @conference = @meeting.conference
      @conference.should be_a(Conference)
      @conference.id.should eql(3)
      @conference.name.should eql('Different')
    end
    
    it 'allows setting with actual class objects in an initial hash' do
      @conference = Conference.new(:id => 4, :name=>'Another')
      @meeting2 = Meeting.new(:id => 2, :conference => @conference)
      @meeting2.conference_id.should eql(4)
      @conference = @meeting2.conference
      @conference.should be_a(Conference)
      @conference.id.should eql(4)
      @conference.name.should eql('Another')
    end
  end
  
  context "when the resource has a has_one association" do
    before(:each) do
      @meeting = Meeting.new(:id => 1, :speaker => {:id=>22, :name=>'Speaking'})
    end

    it "returns the association with the correct type and all nested attributes" do
      @speaker = @meeting.speaker
      @speaker.should be_a(Speaker)
      @speaker.id.should eql(22)
      @speaker.name.should eql('Speaking')
    end
    
    it "still allows setting the association the old-fashioned way" do
      @speaker = Speaker.new({:id=>30, :name=>'Speaking up'})
      @meeting.speaker = @speaker
      @speaker = @meeting.speaker
      @speaker.should be_a(Speaker)
      @speaker.id.should eql(30)
      @speaker.name.should eql('Speaking up')
    end
    
    it 'allows setting with actual class objects in an initial hash' do
      @speaker = Speaker.new({:id=>40, :name=>'Speaking out'})
      @meeting2 = Meeting.new(:id => 3, :speaker => @speaker)
      @speaker = @meeting2.speaker
      @speaker.should be_a(Speaker)
      @speaker.id.should eql(40)
      @speaker.name.should eql('Speaking out')
    end
  end
  
  context "when the resource has a has_many association" do
    before(:each) do
      @meeting = Meeting.new(:id => 1, :attendees => [{:id=>1, :name=>'First'}, {:id=>2, :name=>'Second'}, {:id=>7, :name=>'Last'}])
    end

    it "returns the association with the correct type and all nested attributes" do
      @attendees = @meeting.attendees
      @attendees.size.should eql(3)
      @attendees.each {|a| a.should be_a(Attendee) }
      @attendees.first.id.should eql(1)
      @attendees.first.name.should eql('First')
      @attendees.second.id.should eql(2)
      @attendees.second.name.should eql('Second')
      @attendees.last.id.should eql(7)
      @attendees.last.name.should eql('Last')
    end
    
    it 'allows setting with actual class objects in an initial hash' do
      @attendees = [Attendee.new(:id=>4,:name=>'Forth'), Attendee.new(:id=>5,:name=>'A fifth')]
      @meeting2 = Meeting.new(:id => 3, :attendees => @attendees)
      @attendees = @meeting2.attendees
      @attendees.size.should eql(2)
      @attendees.each {|a| a.should be_a(Attendee) }
      @attendees.first.id.should eql(4)
      @attendees.first.name.should eql('Forth')
      @attendees.second.id.should eql(5)
      @attendees.second.name.should eql('A fifth')
    end
  end
  
  
end
