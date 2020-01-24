# frozen_string_literal: true

require 'slack-ruby-client'

class SlackClient
  def initialize(channel, message)
    @channel = channel
    @message = message
  end

  def post
    configure
    client = Slack::Web::Client.new
    client.chat_postMessage(channel: @channel, text: 'Hello World', as_user: true)
  end

  private

  def configure
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
      raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
    end
  end
end
