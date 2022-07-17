require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET #index" do
    let!(:non_current_article) { FactoryBot.create :non_current_article }
    let(:file) { File.read('spec/mock_data/articles.json') }

    before :each do
      allow_any_instance_of(ArticleDataService).to receive(:file).and_return(file)
      get "/api/v1/articles"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "only returns the current article" do
      json_response = JSON.parse(response.body)
      expect(Article.all.count).to eq(26)
      expect(json_response.count).to eq(25)
    end
  end

  describe "PUT #update" do
    let(:article) { FactoryBot.create :current_article, liked: false }
    let(:action) { put "/api/v1/articles/#{article.id}", params: { article: { id: article.id, liked: true } } }
    let(:failed_action) { put "/api/v1/articles/#{article.id}", params: { liked: true } }

    it "successfully updates the article" do
      expect{ action }.to change{ article.reload.liked }.from(false).to(true)
    end

    it "throws an error if the request is not formatted properly" do
      expect { failed_action }.to raise_error(KeyError, "param is missing or the value is empty: article")
    end
  end
end
