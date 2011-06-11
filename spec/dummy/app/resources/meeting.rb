class Meeting < PolarisResource::Base
  property :title
  
  belongs_to :conference
  has_many   :attendees
  has_one    :speaker
end