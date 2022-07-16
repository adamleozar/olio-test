class ArticleDataService
  def fecth_data
    article_data = JSON.parse(file)
    create_new_articles(article_data)
    update_removed_articles(article_data)
  end

  def file
    File.read(URI.open("https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json"))
  end

  private

  def create_new_articles(article_data)
    article_data.each do |article|        
      existing_article = Article.find_by(external_id: article["id"])

      next if existing_article.present?
      begin
        Article.create!(
            external_id: article["id"],
            title: article["title"],
            description: article["description"],
            section: article["section"],
            expiry: article["expiry"],
            current: true
        )
      rescue => e
        Rails.logger.error "failed to create new article with external id: #{article["id"]}"
      end
    end
  end

  def update_removed_articles(article_data)
    old_arcticle_ids = Article.all.pluck(:external_id)
    current_article_ids = article_data.pluck("id")
    non_current_article_ids = old_arcticle_ids - current_article_ids

    Article.where(external_id: non_current_article_ids, current: true).update_all(current: false)
  end
end