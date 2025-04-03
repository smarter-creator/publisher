class Event < ApplicationRecord
  belongs_to :publisher
  has_many :event_occurrences, dependent: :destroy

  validates :title, :start_datetime, :end_datetime, presence: true
  validate :end_after_start

  after_save :generate_occurrences

  private

  def end_after_start
    return if end_datetime.blank? || start_datetime.blank?
    errors.add(:end_datetime, "must be after start datetime") if end_datetime <= start_datetime
  end

def generate_occurrences
  event_occurrences.destroy_all
  return unless recurring?
  return if recurrence_rule.blank? || recurrence_rule == "custom"

  schedule = IceCube::Schedule.new(start_datetime)
  schedule.add_recurrence_rule(IceCube::Rule.from_hash(RecurringSelect.dirty_hash_to_rule(recurrence_rule).to_hash))

  duration = end_datetime ? (end_datetime - start_datetime) : nil
  occurrences_end = end_datetime || (start_datetime + 1.year) # Use real `end_datetime` if available

  schedule.occurrences(occurrences_end).each do |occurrence|
    event_occurrences.create(
      occurrence_datetime: occurrence,
    )
  end
end

end
