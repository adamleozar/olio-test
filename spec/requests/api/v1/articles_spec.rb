require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  let!(:non_current_article) { FactoryBot.create :non_current_article }
  let(:file) { File.read('spec/mock_data/articles.json') }

  before :each do
    allow_any_instance_of(ArticleDataService).to receive(:file).and_return(file)
    get "/api/v1/articles"
  end

  describe "GET /index" do
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "only returns the current article" do
      json_response = JSON.parse(response.body)
      expect(Article.all.count).to eq(26)
      expect(json_response.count).to eq(25)
    end
  end
end
