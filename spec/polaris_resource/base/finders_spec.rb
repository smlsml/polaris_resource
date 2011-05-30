require 'spec_helper'

class Dog < PolarisResource::Base
  property :name
  property :breed
end

describe PolarisResource::Base::Finders, "#find" do
  
  context "when the argument is a single integer" do
    
    context "when this record exists on the external service" do
      
      before(:each) do
        body = {
          :status  => 200,
          :content => Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)
        }
        @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
        PolarisResource::Request.stub(:get).and_return(@response)
      end
      
      it "makes a request to /dogs/1 at the external service" do
        PolarisResource::Request.should_receive(:get).with("/dogs/1").and_return(@response)
        Dog.find(1)
      end
      
      it "returns the instance representing this found record" do
        @dog = Dog.find(1)
        @dog.should be_a(Dog)
        @dog.id.should eql(1)
        @dog.name.should eql("Daisy")
        @dog.breed.should eql("English Bulldog")
      end
      
    end
    
    context "when this record does not exist on the external service" do
      
      before(:each) do
        body = {
          :status  => 404,
          :content => nil
        }
        @response = PolarisResource::Response.new(:code => 404, :headers => "", :body => body.to_json, :time => 0.3)
        PolarisResource::Request.stub(:get).and_return(@response)
      end
      
      it "raises a RecordNotFound error" do
        lambda { Dog.find(1) }.should raise_error(PolarisResource::RecordNotFound, "Couldn't find Dog with ID=1")
      end
      
    end
    
  end
  
  context "when the argument is a single array" do
    
    context "when all records exists on the external service" do
      
      before(:each) do
        dogs =  [Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)]
        dogs << Dog.new(:name => "Wilbur", :breed => "Hounddog").attributes.merge(:id => 2)
        dogs << Dog.new(:name => "Fido", :breed => "Dalmatian").attributes.merge(:id => 3)
        body = {
          :status  => 200,
          :content => dogs
        }
        @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
        PolarisResource::Request.stub(:get).and_return(@response)
      end
      
      it "makes a request to /dogs?ids=1,2,3 at the external service" do
        PolarisResource::Request.should_receive(:get).with("/dogs?ids=1,2,3").and_return(@response)
        Dog.find([1,2,3])
      end
      
      it "returns an array of instances representing these found records" do
        @dogs = Dog.find([1,2,3])
        @dogs.should be_an(Array)
        @dogs.should have(3).dogs
        @dogs.each do |dog|
          dog.should be_a(Dog)
        end
      end
      
    end
    
    context "when there is a requested record that does not exist on the external service" do
      
      before(:each) do
        body = {
          :status  => 404,
          :content => nil
        }
        @response = PolarisResource::Response.new(:code => 404, :headers => "", :body => body.to_json, :time => 0.3)
        PolarisResource::Request.stub(:get).and_return(@response)
      end
      
      it "raises a RecordNotFound error" do
        lambda { Dog.find([1,2,3]) }.should raise_error(PolarisResource::RecordNotFound, "Couldn't find all Dogs with IDs (1, 2, 3)")
      end
      
    end
    
  end
  
  context "when there are multiple arguments, each being an integer" do
    
    context "when all records exists on the external service" do
      
      before(:each) do
        dogs =  [Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)]
        dogs << Dog.new(:name => "Wilbur", :breed => "Hounddog").attributes.merge(:id => 2)
        dogs << Dog.new(:name => "Fido", :breed => "Dalmatian").attributes.merge(:id => 3)
        body = {
          :status  => 200,
          :content => dogs
        }
        @response = PolarisResource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
        PolarisResource::Request.stub(:get).and_return(@response)
      end
      
      it "makes a request to /dogs?ids=1,2,3 at the external service" do
        PolarisResource::Request.should_receive(:get).with("/dogs?ids=1,2,3").and_return(@response)
        Dog.find(1,2,3)
      end
      
      it "returns an array of instances representing these found records" do
        @dogs = Dog.find(1,2,3)
        @dogs.should be_an(Array)
        @dogs.should have(3).dogs
        @dogs.each do |dog|
          dog.should be_a(Dog)
        end
      end
      
    end
    
    context "when there is a requested record that does not exist on the external service" do
      
      before(:each) do
        body = {
          :status  => 404,
          :content => nil
        }
        @response = PolarisResource::Response.new(:code => 404, :headers => "", :body => body.to_json, :time => 0.3)
        PolarisResource::Request.stub(:get).and_return(@response)
      end
      
      it "raises a RecordNotFound error" do
        lambda { Dog.find(1,2,3) }.should raise_error(PolarisResource::RecordNotFound, "Couldn't find all Dogs with IDs (1, 2, 3)")
      end
      
    end
    
  end
  
end

describe PolarisResource::Base::Finders, "#all" do
  pending
end

describe PolarisResource::Base::Finders, "#where" do
  pending
end

describe PolarisResource::Base::Finders, "#limit" do
  pending
end

describe PolarisResource::Base::Finders, "#page" do
  pending
end

describe PolarisResource::Base::Finders, "#results_per_page" do
  pending
end