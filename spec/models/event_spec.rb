require 'rails_helper'
RSpec.describe Event, type: :model do
  let(:publisher) { Publisher.create(title: "Test Publisher", description: "A sample publisher") }
  let(:event) { Event.create(title: "Test Event", start_datetime: Time.current, end_datetime: Time.current + 2.hours, publisher: publisher) }

  it "should be valid with valid attributes" do
    expect(event).to be_valid
  end

  it "should not be valid without a title" do
    event.title = nil
    expect(event).to_not be_valid
  end

  it "should belong to a publisher" do
    expect(event.publisher).to eq(publisher)
  end
end