require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  let!(:current_article) { FactoryBot.create :current_article }
  let!(:non_current_article) { FactoryBot.create :non_current_article }

  before :each do
    get "/api/v1/articles"
  end

  describe "GET /index" do
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "only returns the current article" do
      json_response = JSON.parse(response.body)
      expect(json_response.count).to eq(1)
      expect(json_response.first["current"]).to eq(true)
    end
  end
end
