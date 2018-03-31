# frozen_string_literal: true

module Clients
  class Twitter
    include Singleton

    def initialize
      @client ||= ::Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      end
    end

    def search(text, options)
      client.search(text, options)
    end

    private

    attr_reader :client
  end
end
