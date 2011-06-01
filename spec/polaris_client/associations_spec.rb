require 'spec_helper'

class Item < PolarisResource::Base
  belongs_to :conference
  has_many   :attendees
  has_one    :speaker
end

class Purchase < ActiveRecord::Base
  belongs_to_resource :item
  
  attr_accessor :item_id
end

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
      
      PolarisResource::Request.stub(:get) do |uri|
        case uri
        when '/items/3'
          item_response
        end
      end
      
      @item = Item.find(3)
      
    end
    
    it "returns the association object when the id is specified" do
      @purchase = Purchase.new
      @purchase.item_id=3
      @purchase.item.should be_a(Item)
      @purchase.item.id.should eql(3)
    end
    
    it 'can set an association directly' do
      @purchase = Purchase.new
      @purchase.item = @item
      @purchase.item_id.should eql(3)
      @purchase.item.should be_a(Item)
      @purchase.item.id.should eql(3)
    end
    
    it "returns nil when the id is not specified" do
      @purchase = Purchase.new
      @purchase.item.should be_nil
    end
    
  end
  
end