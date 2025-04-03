class EventOccurrence < ApplicationRecord
    belongs_to :event
    validates :occurrence_datetime, presence: true
end
  