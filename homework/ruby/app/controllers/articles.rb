class ArticleController
  
  def create_article(article)
    article_not_exists = Article.find_by(title: article['title'])

    if article_not_exists
      return { ok: false, msg: 'Article with given title already exists' }
    end

    new_article = Article.new(title: article['title'])
    if new_article.save
      { ok: true, obj: new_article }
    else
      { ok: false, msg: 'Failed to create the article' }
    end
  rescue StandardError
    { ok: false }
  end

  def update_article(id, new_data)
    article = Article.find_by(id: id)
  
    if article
      article.title = new_data['title']
      article.content = new_data['content']
  
      {
        ok: true, obj: article
      }
    else
      { ok: false, msg: 'Article could not be found' }
    end
  rescue StandardError
    { ok: false }
  end
  
    


  def get_article(id)
    
    res = Article.find_by(id: id)

    if res
      { ok: true, data: res }
    else
      { ok: false, msg: 'Article not found' }
    end
  rescue StandardError
    { ok: false }
  end

  def delete_article(id)
    res = Article.find_by(id: id)
  
    if res
      delete_count = Article.delete(id)
  
      if delete_count == 0
        { ok: true }
      else
        { ok: true, delete_count: delete_count }
      end
    else
      { ok: false }
    end
  end
  

  def get_batch
    articles = Article.all

    if articles.any?
      { ok: true, data: articles }
    else
      { ok: false, msg: 'No articles found' }
    end
  rescue StandardError
    { ok: false }
  end
end
