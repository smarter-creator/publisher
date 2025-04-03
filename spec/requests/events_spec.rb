require 'rails_helper'
RSpec.describe "Events API", type: :request do
  let!(:publisher) { Publisher.create(title: "Test Publisher", description: "A sample publisher") }
  let!(:event) { Event.create(title: "Test Event", start_datetime: Time.current, end_datetime: Time.current + 2.hours, publisher: publisher) }

  describe "GET /events" do
    it "returns all events" do
      get events_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /events" do
    it "creates a new event" do
      post events_path, params: { event: { title: "New Event", start_datetime: Time.current, end_datetime: Time.current + 2.hours, publisher_id: publisher.id } }
      expect(response).to have_http_status(302)
    end
  end
end