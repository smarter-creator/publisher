require 'rails_helper'
RSpec.describe "Publishers API", type: :request do
  let!(:publishers) { Publisher.create([{ title: "Publisher 1", description: "First publisher" }, { title: "Publisher 2", description: "Second publisher" }]) }

  describe "GET /publishers" do
    it "returns all publishers" do
      get publishers_path
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /publishers" do
    it "creates a new publisher" do
      post publishers_path, params: { publisher: { title: "New Publisher", description: "A new test publisher" } }
      expect(response).to have_http_status(302)
      expect(Publisher.count).to eq(3)
    end
  end
end