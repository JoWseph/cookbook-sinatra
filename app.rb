require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'

require_relative 'recipe'
require_relative 'cookbook'

set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)

get '/' do
  @all_recipes = cookbook.all
  erb :index
end

get '/description/:item_index' do
  @recipe = cookbook.select_recipe(params[:item_index].to_i)
  erb :description
end

get '/form_creation' do
  erb :form_creation
end

post '/recipe' do
  cookbook.add_recipe(Recipe.new(params[:name], params[:desc], false))
  redirect('/')
end

get '/remove/:index' do
  cookbook.remove_recipe(params[:index].to_i)
  redirect('/')
end

get '/mark_as_done/:index' do
  cookbook.mark_as_done(params[:index].to_i)
  redirect('/')
end
