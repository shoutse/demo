class EventGroupship < ActiveRecord::Base
  belongs_to :event
  belongs_to :group
end
