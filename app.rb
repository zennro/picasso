require 'sinatra'
require 'date'
require 'json'

require_relative './config/boot'

db = DB.new(Settings.db)

tags = Settings.data[:sources].map(&:first)
vars = Settings.data[:sources].map(&:last)

helpers BasicAuthHelper, ValidationsHelper

post '/data/:tag/:variable/:timestamp/:value' do |tag, variable, timestamp, value|
  require_basic_auth(Settings.api_user, Settings.api_pass)

  validate_inclusion_of(tag, tags)
  validate_inclusion_of(variable, vars)

  db.insert(timestamp, tag, variable, value)
end

get '/data/:tag/:variable/:from/:to/:step' do |tag, variable, from, to, step|
  validate_inclusion_of(tag, tags)
  validate_inclusion_of(variable, vars)

  data = db.select(tag, variable, from, to)
  Interpolate.zerofill(from, to, step, data).to_json
end

get '/' do
  erb :index, :locals => { :settings => Settings }
end
