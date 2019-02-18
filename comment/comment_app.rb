require 'sinatra/base'
require 'sinatra/reloader'
require 'json/ext' # for .to_json
require 'uri'
require 'mongo'
require_relative 'helpers'

class CommentApp < Sinatra::Base

  set :root, File.dirname(__FILE__)

  helpers Sinatra::CommentApp::Helpers

  mongo_host = ENV.fetch('COMMENT_DATABASE_HOST')  { 'comment_db' }
  mongo_port = ENV.fetch('COMMENT_DATABASE_PORT') { 27017 }
  mongo_database = ENV.fetch('COMMENT_DATABASE')  { 'comments' }

  configure do
    register Sinatra::Reloader

    db = Mongo::Client.new(["#{mongo_host}:#{mongo_port}"], database: mongo_database, heartbeat_frequency: 2)
    set :mongo_db, db[:comments]
    set :bind, '0.0.0.0'
  end

  get '/:id/comments' do
    id   = comment_id(params[:id])
    settings.mongo_db.find(post_id: "#{id}").to_a.push({ post_id: "#{id}", name: 'hui', email: 'deded', body: 'hui2'}).to_json
  end

  post '/add_comment/?' do
    content_type :json
    halt 400, json(error: 'No name provided') if params['name'].nil? or params['name'].empty?
    halt 400, json(error: 'No comment provided') if params['body'].nil? or params['body'].empty?
    db = settings.mongo_db
    result = db.insert_one post_id: params['post_id'], name: params['name'], email: params['email'], body: params['body'], created_at: params['created_at']
    db.find(_id: result.inserted_id).to_a.first.to_json
  end

  get '/*' do |request|
    halt 404
  end
end
