require 'spec_helper'

describe PolarisResource::Relation, ".where" do
  
  before(:each) do
    @dogs = [
      Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1),
      Dog.new(:name => "Wilbur", :breed => "Hounddog").attributes.merge(:id => 2),
      Dog.new(:name => "Fido", :breed => "Dalmatian").attributes.merge(:id => 3)
    ]
  end
  
  it "makes a request to find all of the given records, with the where parameters" do
    Dog.should_receive(:get).with("/dogs", { :name => "Daisy", :breed => "English Bulldog" }).and_return(@dogs)
    Dog.where(:name => "Daisy", :breed => "English Bulldog").all
  end
  
end

describe PolarisResource::Relation, ".limit" do
  
  before(:each) do
    @dogs = [
      Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1),
      Dog.new(:name => "Wilbur", :breed => "Hounddog").attributes.merge(:id => 2),
      Dog.new(:name => "Fido", :breed => "Dalmatian").attributes.merge(:id => 3)
    ]
  end
  
  it "makes a request to find all of the given records, with the limit parameter" do
    Dog.should_receive(:get).with("/dogs", { :limit => 2 }).and_return(@dogs)
    Dog.limit(2).all
  end
  
end

describe PolarisResource::Relation, ".page" do
  
  before(:each) do
    @dogs =  [
      Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1),
      Dog.new(:name => "Wilbur", :breed => "Hounddog").attributes.merge(:id => 2),
      Dog.new(:name => "Fido", :breed => "Dalmatian").attributes.merge(:id => 3)
    ]
  end
  
  it "makes a request to find all of the given records, with the chained parameters" do
    Dog.results_per_page = 10
    Dog.should_receive(:get).with("/dogs", { :limit => 10, :offset => 20 }).and_return(@dogs)
    Dog.page(3).all
  end
  
end

describe PolarisResource::Relation, "chaining relations" do
  
  before(:each) do
    @dogs =  [
      Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1),
      Dog.new(:name => "Wilbur", :breed => "Hounddog").attributes.merge(:id => 2),
      Dog.new(:name => "Fido", :breed => "Dalmatian").attributes.merge(:id => 3)
    ]
  end
  
  it "makes a request to find all of the given records, with the chained parameters" do
    Dog.results_per_page = 10
    Dog.should_receive(:get).with("/dogs", { :name => "Daisy", :breed => "English Bulldog", :limit => 2, :offset => 20 }).and_return(@dogs)
    Dog.where(:name => "Daisy", :breed => "English Bulldog").page(3).limit(2).all
  end
  
end