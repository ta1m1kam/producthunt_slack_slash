# frozen_string_literal: true

require 'sinatra'
#require_relative './lib/slack_client/slack_client'
require_relative './lib/producthunt/producthunt'

post '/' do
  message
end

def message
  source = ProductHunt.new
  producthunts = source.producthunts
  message = ''
  producthunts.each do |p|
    message += p.name + "\n"
  end
  message
end
