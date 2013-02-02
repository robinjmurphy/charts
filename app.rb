#! /usr/bin/env ruby

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require 'sinatra'
require 'charts'

get '/' do
    @chart = Charts::Chart.find_by_path 'radio1/chart/singles'
    @title = @chart.name
    erb :chart
end

get '/charts/*' do
    path = params['splat'][0]
    begin
        @chart = Charts::Chart.find_by_path path
        @title = @chart.name
        erb :chart
    rescue Charts::Exceptions::ChartNotFound => exception
        status 404
        body exception.message
    end
end

get '/entries/*' do
    path = params['splat'][0]
    @chart = Charts::Chart.find_by_path path
    @entries = @chart.entries
    erb(:entries, :layout => false)
end

post '/read_playlist' do
    playlist_url = params['playlist']
    begin
        mp3_url = Charts::Url.new.mp3_from_playlist playlist_url
        JSON.generate({ :mp3_url => mp3_url })
    rescue Charts::Exceptions::PlaylistNotFound 
        status 404
        body exception.message
    end
end