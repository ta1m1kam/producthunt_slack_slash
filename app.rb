# frozen_string_literal: true

require 'time'
require 'sinatra'
require_relative './lib/slack_notifier/slack_notifier'
require_relative './lib/producthunt/producthunt'

get '/' do
  'Hello, This is ProductHunt Slack Slash'
end

post '/' do
  post_slack
  ''
end

def post_slack
  SlackNotifier.new(message, channel: '#memo', attachments: attachments).notify
end

def message
  ":first_place_medal: ProductHunt :first_place_medal: "
end

def attachments
  fields = products.map.with_index do |product, index|
    {
      title: "#{index+1}位: #{product.name} `#{product.category}`",
      value: "#{product.description} \n",
      short: false
    }
  end

  {
    fallback: 'ProductHunt',
    color: 'good',
    title: "#{today} のランキング",
    title_link: "https://www.producthunt.com/",
    footer: 'ProductHunt',
    footer_icon: 'https://api.url2png.com/v6/P5329C1FA0ECB6/790272390317dc724643b1ca88f5da6e/png/?url=https%3A%2F%2Fwww.producthunt.com%2F',
    fields: fields
  }
end

def products
  source = ProductHunt.new
  source.producthunts
end

def today
  Time.new.strftime("%Y-%m-%d")
end
