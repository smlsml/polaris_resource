require 'spec_helper'

describe PolarisResource::Persistence, "#save" do
  
  context "when the instance is a new record" do
    
    before(:each) do
      stub_web!
      @california = State.new(
        :name    => 'California',
        :capital => 'Sacramento',
        :motto   => 'Eureka!'
      )
    end
    
    it "updates the attributes to match those returned in the response" do
      @california.id.should be_nil
      @california.save
      @california.id.should eql(1)
    end
    
    it "marks the instance as not new" do
      @california.should be_new_record
      @california.save
      @california.should_not be_new_record
    end
    
    it "sets the errors hash based on the response" do
      @california.save
      @california.errors.should be_empty
    end
    
    it "sets the valid? flag based on the response" do
      @california.save
      @california.should be_valid
    end
    
  end
  
  context "when the instance is not a new record" do
    
    before(:each) do
      stub_web!
      @state = State.new(
        :name    => 'California',
        :capital => 'Sacramento',
        :motto   => 'Eureka!'
      )
      @state.save
      
      @state.name    = 'Oregon'
      @state.capital = 'Salem'
      @state.motto   = 'She flies with her own wings'
      @state.save
    end
    
    it 'has a new name attribute' do
      @state.name.should eql('Oregon')
    end
    
    it 'has a new capital attribute' do
      @state.capital.should eql('Salem')
    end
    
    it 'has a new motto attribute' do
      @state.motto.should eql('She flies with her own wings')
    end
    
    it 'is still valid' do
      @state.should be_valid
    end
    
    it 'still has no errors' do
      @state.errors.should be_empty
    end
    
  end
  
  def stub_web!
    PolarisResource::Configuration.hydra.stub(:post, "#{PolarisResource::Configuration.host}/states").and_return(build_polaris_response(
      201,
      {
        :id      => 1,
        :valid   => true,
        :errors  => {},
        :name    => 'California',
        :capital => 'Sacramento',
        :motto   => 'Eureka!'
      }
    ))
    
    PolarisResource::Configuration.hydra.stub(:post, "#{PolarisResource::Configuration.host}/states/1").and_return(build_polaris_response(
      200,
      {
        :id      => 1,
        :valid   => true,
        :errors  => {},
        :name    => 'Oregon',
        :capital => 'Salem',
        :motto   => 'She flies with her own wings'
      }
    ))
  end
  
end

describe PolarisResource::Persistence, "#update_attributes" do
  
  before(:each) do
    stub_web!
    @state = State.new(
      :name    => "California",
      :capital => "Sacramento",
      :motto   => "Eureka!"
    )
    @state.save
  end
  
  it "sets the attributes to their new values" do
    @state.update_attributes(:name => "Oregon", :capital => "Salem", :motto => "She flies with her own wings")
    @state.name.should eql("Oregon")
    @state.capital.should eql("Salem")
    @state.motto.should eql("She flies with her own wings")
  end
  
  it "calls .save on the record" do
    @state.should_receive(:save)
    @state.update_attributes(
      :name    => 'Oregon',
      :capital => 'Salem',
      :motto   => 'She flies with her own wings'
    )
  end
  
  def stub_web!
    PolarisResource::Configuration.hydra.stub(:post, "#{PolarisResource::Configuration.host}/states").and_return(build_polaris_response(
      201,
      {
        :id      => 1,
        :valid   => true,
        :errors  => {},
        :name    => 'California',
        :capital => 'Sacramento',
        :motto   => 'Eureka!'
      }
    ))
    
    PolarisResource::Configuration.hydra.stub(:post, "#{PolarisResource::Configuration.host}/states/1").and_return(build_polaris_response(
      200,
      {
        :id      => 1,
        :valid   => true,
        :errors  => {},
        :name    => 'Oregon',
        :capital => 'Salem',
        :motto   => 'She flies with her own wings'
      }
    ))
  end
  
end