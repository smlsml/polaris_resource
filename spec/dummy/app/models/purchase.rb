class Purchase < ActiveRecord::Base
  belongs_to_resource :item
end