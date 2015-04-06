require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'

configure :development do
  register Sinatra::Reloader
end

configure do
  FileUtils.mkdir_p("#{settings.public_folder}/music")
end

get '/' do
  json({message: "hello, world"})
end
