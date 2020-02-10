require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

class PrepareDB
  attr_reader :data
  def initialize(path: 'db/db.json')
    file = File.read(path)
    @data = JSON.parse(file, symbolize_names: true)
  end

  def keys
    @data.keys
  end 

  def search(key, str)
    @data[key][:data].collect { |e| e if e[:name].include?(str) }.compact
  end
end

class JSONServer < Sinatra::Base
  set :db, PrepareDB.new(path: 'db/db.json')

  settings.db.keys.each do |key|
    get "/#{key}" do
        db = settings.db
        headers('Access-Control-Allow-Origin' => '*')
        headers('Access-Control-Allow-Methods' => 'POST, GET, OPTIONS')
        length = params[:length].to_i || 10
        start = params[:start].to_i || 0
        draw = params[:draw].to_i || 0
        search_value = params[:search][:value]
        data = search_value.length > 0 ? db.search(key, search_value) : db.data[key.to_sym][:data]
        number_of_elements = data.size
        records_filtered = number_of_elements
        json({ draw: draw, recordsTotal: number_of_elements, recordsFiltered: records_filtered, data: data.slice(start, length) })
    end
  end
end
