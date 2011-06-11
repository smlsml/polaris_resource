class Dog < PolarisResource::Base
  property :name
  property :breed
  
  validates_presence_of :name
  
  def bark!
    "Bow-wow-wow"
  end
end