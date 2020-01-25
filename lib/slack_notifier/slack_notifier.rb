# frozen_string_literal: true

require 'slack-notifier'

class SlackNotifier
  def initialize(message, channel: nil, attachments: nil)
    @message = message
    @channel = channel
    @attachments = attachments
    @notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'], channel: @channel)
  end

  def notify
    @notifier.ping(@message, notifier_options)
  end

  private

  def notifier_options
    { attachments: @attachments }.compact
  end
end
