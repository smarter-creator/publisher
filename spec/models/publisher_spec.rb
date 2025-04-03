require 'rails_helper'
RSpec.describe Publisher, type: :model do
  let(:publisher) { Publisher.create(title: "Test Publisher", description: "A sample publisher") }

  it "should be valid with valid attributes" do
    expect(publisher).to be_valid
  end

  it "should not be valid without a title" do
    publisher.title = nil
    expect(publisher).to_not be_valid
  end

  it "can have many events" do
    event1 = publisher.events.create(title: "Event 1", start_datetime: Time.current, end_datetime: Time.current + 2.hours)
    event2 = publisher.events.create(title: "Event 2", start_datetime: Time.current + 1.day, end_datetime: Time.current + 1.day + 2.hours)
    expect(publisher.events.count).to eq(2)
  end
end