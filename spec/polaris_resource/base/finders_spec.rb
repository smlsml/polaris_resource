require 'spec_helper'

class Dog < Polaris::Resource::Base
  property :name
  property :breed
end

describe Polaris::Resource::Base::Finders, "#find" do
  
  context "when the argument is a single integer" do
    
    context "when this record exists on the external service" do
      
      before(:each) do
        body = {
          :status  => 200,
          :content => Dog.new(:name => "Daisy", :breed => "English Bulldog").attributes.merge(:id => 1)
        }
        @response = Polaris::Resource::Response.new(:code => 200, :headers => "", :body => body.to_json, :time => 0.3)
        Polaris::Resource::Request.stub(:get).and_return(@response)
      end
      
      it "makes a request to /dogs/1 at the external service" do
        Polaris::Resource::Request.should_receive(:get).with("/dogs/1").and_return(@response)
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
      
    end
    
  end
  
  context "when the argument is a single array" do
    pending
  end
  
  context "when there are arguments, each being an integer" do
    pending
  end
  
end

describe Polaris::Resource::Base::Finders, "#all" do
  pending
end

describe Polaris::Resource::Base::Finders, "#where" do
  pending
end

describe Polaris::Resource::Base::Finders, "#limit" do
  pending
end

describe Polaris::Resource::Base::Finders, "#page" do
  pending
end

describe Polaris::Resource::Base::Finders, "#results_per_page" do
  pending
end