class Author < PolarisResource::Base
  property :name

  has_many :books
end