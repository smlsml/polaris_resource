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
      item = Item.new(:id => 3)
      Item.stub(:get).and_return(item)
      
      @item = Item.find(3)
    end
    
    it "returns the association object when the id is specified" do
      @purchase = Purchase.new
      @purchase.item_id = 3
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
      @purchase.item.should eql(nil)
    end
    
  end
  
end