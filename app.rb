require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'systemu'
require 'securerandom'
require 'open-uri'
require 'fileutils'

configure :development do
  register Sinatra::Reloader
end

configure do
  FileUtils.mkdir_p("#{settings.public_folder}/music")
end

helpers do
  def download(uri)
    m4a_path = "#{settings.public_folder}/music/#{SecureRandom.hex(5)}.m4a"
    open(m4a_path, 'w') do |output|
      open(uri) do |data|
        output.write(data.read)
      end
    end
    raise unless File.exist? m4a_path
    m4a_path
  end

  def convert(m4a_path)
    mp3_name = File.basename(m4a_path.sub(/\.m4a$/, ".mp3"))
    mp3_path = "#{settings.public_folder}/music/#{mp3_name}"
    statuses = systemu "yes | ffmpeg -i #{m4a_path} -acodec mp3 -ac 2 -ab 160 #{mp3_path}"
    raise if statuses[2].index(/Invalid\ data/)
    raise unless File.exist? mp3_path
    mp3_path
  end

  def uri_of(mp3)
    "http://#{request.env['HTTP_HOST']}/music/#{File.basename(mp3)}"
  end

  def render_json(response)
    if response[:error].nil?
      json response
    else
      status response[:error]
      json response
    end
  end
end

get '/' do
  render_json({message: "hello, world"})
end

get '/convert' do
  preview = params[:uri]
  response = {}
  if (preview.nil? || preview.empty?)
    response = {error: 404}
  else
    begin
      m4a = download preview
      mp3 = convert m4a
      response = {uri: uri_of(mp3)}
    rescue
      response = {error: 500}
    end
  end
  render_json response
end
