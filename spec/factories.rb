FactoryBot.define do
  factory(:current_article, class: Article) do
    current { true }
    external_id { 123 }
    title { "Article 1" }
    description { "Device only but refills are available most places" }
    section { "Product" }
    liked { false }
    expiry { "2021-04-09T10:49:15.000Z" }
  end
  factory(:non_current_article, class: Article) do
    current { false }
    external_id { 123 }
    title { "Article 2" }
    description { "Device only but refills are available most places" }
    section { "Food" }
    liked { false }
    expiry { "2021-04-09T10:49:15.000Z" }
  end
end