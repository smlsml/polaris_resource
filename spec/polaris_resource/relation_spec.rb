require 'spec_helper'

describe PolarisResource::Relation, "chaining relations" do
  
  before(:each) do
    dogs =  [Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)]
    dogs << Dog.new(:name => "Wilbur", :breed => "Hounddog").attributes.merge(:id => 2)
    dogs << Dog.new(:name => "Fido", :breed => "Dalmatian").attributes.merge(:id => 3)
    body = {
      :status  => 200,
      :content => dogs
    }
    @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
  end
  
  it "makes a request to find all of the given records, with the chained parameters" do
    PolarisResource::Request.should_receive(:get).with("/dogs", { :name => "Daisy", :breed => "English Bulldog", :limit => 2, :offset => 20 }).and_return(@response)
    Dog.where(:name => "Daisy", :breed => "English Bulldog").page(3).limit(2).all
  end
  
end
