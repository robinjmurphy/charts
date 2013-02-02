#! /usr/bin/env ruby

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require 'sinatra'
require 'xmlsimple'
require 'json'
require 'rest-client'
require 'charts'

get '/' do
    @chart = Charts::Chart.find_by_path 'radio1/chart/singles'
    @title = @chart.name

    erb :chart
end

get '/charts/*' do
    path = params['splat'][0]
    @chart = Charts::Chart.find_by_path path
    @title = @chart.name

    erb :chart
end

get '/entries/*' do
    path = params['splat'][0]
    @chart = Charts::Chart.find_by_path path
    @entries = @chart.entries

    erb(:entries, :layout => false)
end

post '/read_playlist' do
    url = params[:playlist]
    response = RestClient.get(url)
    if (response.code == 200)
        data = XmlSimple.xml_in(response)
        JSON.generate({
            :mp3_url => data['item'][0]['media'][0]['connection'][0]['href']
        })
    end
end