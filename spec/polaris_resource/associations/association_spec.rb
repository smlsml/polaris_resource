require 'spec_helper'

describe PolarisResource::Associations::Association, ".id" do
  
  before(:each) do
    meeting =  Meeting.new(:id => 5, :title => "Rails Development")
    Meeting.stub(:get).and_return(meeting)
  end
  
  it "calls the loaded target and retrieves it's id" do
    @speaker = Speaker.new(:meeting_id => 5)
    @speaker.meeting.id.should eql(5)
  end
  
end

describe PolarisResource::Associations::Association, ".loaded_target" do
  
  before(:each) do
    @meeting =  Meeting.new(:id => 5, :title => "Rails Development")
  end
  
  it "loads target only once" do
    Meeting.should_receive(:get).once.and_return(@meeting)
    @speaker = Speaker.new(:meeting_id => 5)
    @speaker.meeting.id
    @speaker.meeting.id
  end
  
end

describe PolarisResource::Associations::Association, ".method_missing" do

  before(:each) do
    meeting =  Meeting.new(:id => 5, :title => "Rails Development")
    Meeting.stub(:get).and_return(meeting)
  end
  
  it "calls the loaded target and tries the method on the target" do
    @speaker = Speaker.new(:meeting_id => 5)
    @speaker.meeting.title
  end

end