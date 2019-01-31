
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do 
    erb :index  
  end
  
  # "NEW", part of the C in CRUD
  get '/article/new' do 
  	erb :new 
  end 

  # "CREATE", part of the C in CRUD
  post '/articles' do 
  	@a = Article.new(title: params[:title], content: params[:content])
  	@a.save
  	redirect to "/articles/#{@a.id}"
  end
  
  # "INDEX", part of "R" in CRUD
  get '/articles' do
  	@articles = Article.all
  	erb :index
  end

  # "SHOW", part of the R in CRUD
  get '/articles/:id' do
  	@article = Article.find(params[:id])
  	erb :show
  end

  # "EDIT", part of the U in CRUD
  get '/articles/:id/edit' do 
  	@article = Article.find(params[:id])
  	erb :edit 
  end

  # "UPDATE", part of the U in CRUD
  patch '/articles/:id' do 
  	@article = Article.find(params[:id])
  	@article.title = params[:title]
  	@article.content = params[:content]
  	@article.save
    redirect to "/articles/#{@article.id}"
  end 

  # "DELETE", the D in CRUD
  delete '/articles/:id/delete' do 
  	@article = Article.find(params[:id])
  	@article.delete 
  	erb :delete
  end
end
