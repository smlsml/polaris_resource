class Book < PolarisResource::Base
  property :title
  
  belongs_to :author
end