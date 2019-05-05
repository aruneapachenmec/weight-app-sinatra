require 'sinatra'
require 'mongoid'
require "sinatra/namespace"

# DB Setup
Mongoid.load! "mongoid.config"

class Weight
  include Mongoid::Document

  field :value, type: Float
  field :user, type: Integer
  field :unit, type: Integer
  field :created_at, type: DateTime

  validates :value, presence: true
  validates :user, presence: true
  validates :created_at, presence: true
end

get '/' do
  'Hello world'
end

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  get '/weights' do
    Weight.all.to_json
  end

  post '/weights' do
    if Weight.create(user: 1, unit: 0, value: params[:value], created_at: Time.now) 
      Weight.all.to_json
    else
      {error: 'something went wrong'}.to_json
    end
  end
end