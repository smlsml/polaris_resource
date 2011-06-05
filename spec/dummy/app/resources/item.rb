class Item < PolarisResource::Base
  belongs_to :conference
  has_many   :attendees
  has_one    :speaker
end