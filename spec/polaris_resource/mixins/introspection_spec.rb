require 'spec_helper'

describe PolarisResource::Introspection, ".valid?" do
  pending
end

describe PolarisResource::Introspection, ".persisted?" do
  pending
end

describe PolarisResource::Introspection, ".new_record?" do
  
  before(:each) do
    @attendee = Attendee.new
  end
  
  context "when the record is new" do
    
    it "returns true" do
      @attendee.should be_new_record
    end
    
  end
  
  context "when the record is not new" do
    
    before(:each) do
      response = PolarisResource::Response.new(:code => 201, :headers => "", :body => { :status => 201, :content => { :id => 1 } }.to_json, :time => 0.3)
      PolarisResource::Request.stub(:post).and_return(response)
      @attendee.save
    end
    
    it "returns false" do
      @attendee.should_not be_new_record
    end
    
  end
  
end

describe PolarisResource::Introspection, ".destroyed?" do
  pending
end

describe PolarisResource::Introspection, ".respond_to?" do
  pending
end