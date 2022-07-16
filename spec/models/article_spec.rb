require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { 
    described_class.new(
      external_id: 123,
      title: "Article 1",
      description: "Device only but refills are available most places",
      section: "Product",
      current: true,
      liked: false,
      expiry: "2021-04-09T10:49:15.000Z",
    )
  }

  it "is valid with valid attributes" do
    expect(article).to be_valid
  end

  it "is not valid without a title" do
    article.title = nil
    expect(article).to_not be_valid
  end

  it "is not valid without a description" do
    article.description = nil
    expect(article).to_not be_valid
  end

  it "is not valid without a section" do
    article.section = nil
    expect(article).to_not be_valid
  end

  it "is not valid without a current" do
    article.current = nil
    expect(article).to_not be_valid
  end

  it "is not valid without a expiry" do
    article.expiry = nil
    expect(article).to_not be_valid
  end
end
