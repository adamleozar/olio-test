require 'rails_helper'

RSpec.describe ArticleDataService do
  describe "fecth_data" do
    let!(:old_article) { 
      Article.create!(
        external_id: 123,
        title: "Article 1",
        description: "Device only but refills are available most places",
        section: "Product",
        current: true,
        liked: false,
        expiry: "2021-04-09T10:49:15.000Z",
      )
    }

    let(:file) { File.read('spec/mock_data/articles.json') }

    subject { described_class.new }

    before do
      allow_any_instance_of(ArticleDataService).to receive(:file).and_return(file)
      subject.fecth_data
    end

    it "should fetch all the new articles" do
      expect(Article.all.count).to eq(26)
    end

    it "should update old article to non current" do
      expect(Article.find_by(external_id: 123).current).to eq(false)
    end
  end
end