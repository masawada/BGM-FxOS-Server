require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'

configure :development do
  register Sinatra::Reloader
end

get '/' do
  json({message: "hello, world"})
end
