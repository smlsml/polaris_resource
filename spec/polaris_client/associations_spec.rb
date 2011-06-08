require 'spec_helper'

describe PolarisClient::Associations, "#belongs_to" do
  
  it "defines a getter method" do
    Purchase.new.should respond_to(:item)
  end

  it "defines a setter method" do
    Purchase.new.should respond_to('item=')
  end
    
  context "when the belongs_to association is fulfilled by its contracted 'association_id' attribute" do
    
    before(:each) do
      item_body = { :status => 200, :content => { :id => 3 } }
      item_response = PolarisResource::Response.new(:code => 200, :headers => "", :body => item_body.to_json, :time => 0.3)
      
      PolarisResource::Request.stub(:get).and_return(item_response)
      
      @item = Item.find(3)
    end
    
    it "returns the association object when the id is specified" do
      @purchase = Purchase.new
      @purchase.item_id = 3
      @purchase.item.should be_a(Item)
      @purchase.item.id.should eql(3)
    end
    
    it 'can set an association directly' do
      @purchase = Purchase.new(:some_other_attribute=>'here')
      @purchase.item = @item
      @purchase.item_id.should eql(3)
      @purchase.item.should be_a(Item)
      @purchase.item.id.should eql(3)
      @purchase.item.some_other_attribute.should eql('here')
    end
    
    it "returns nil when the id is not specified" do
      @purchase = Purchase.new
      @purchase.item.should be_nil
    end
    
  end
  
end