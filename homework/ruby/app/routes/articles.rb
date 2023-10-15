require 'json'
require_relative '../controllers/articles'

class ArticleRoutes < Sinatra::Base
  use AuthMiddleware

  def initialize
    super
    @articleCtrl = ArticleController.new
  end

  before do
    content_type :json
  end

  get '/' do
    articles = @articleCtrl.get_batch

    if articles[:ok]
      { articles: articles[:data] }.to_json
    else
      { msg: 'Could not get articles.' }.to_json
    end
  end

  get '/:id' do
    id = params['id'].to_i
    article = @articleCtrl.get_article(id)

    if article[:ok]
      { article: article[:data] }.to_json
    else
      { msg: 'Article not found' }.to_json
    end
  end

  post '/' do
    payload = JSON.parse(request.body.read)
    article = @articleCtrl.create_article(payload)

    if article[:ok]
      { msg: 'Article created' }.to_json
    else
      { msg: article[:msg] }.to_json
    end
  end

  put '/:id' do
    id = params['id'].to_i
    payload = JSON.parse(request.body.read)
    summary = @articleCtrl.update_article(id, payload)

    if summary[:ok]
      { msg: 'Article updated' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  delete '/:id' do
    id = params['id'].to_i
    summary = @articleCtrl.delete_article(id)

    if summary[:ok]
      { msg: 'Article deleted' }.to_json
    else
      { msg: 'Article does not exist' }.to_json
    end
  end
end
