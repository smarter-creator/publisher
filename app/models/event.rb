class Event < ApplicationRecord
  belongs_to :publisher
  validates :title, :start_datetime, :end_datetime, presence: true
  serialize :recurrence, coder: JSON
end
