# frozen_string_literal: true

module Clients
  class Twitter
    include Singleton

    def initialize
      @client ||= ::Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['twitter_consumer_key']
        config.consumer_secret = ENV['twitter_consumer_secret']
      end
    end

    def search(text, options)
      client.search(text, options)
    end

    private

    attr_reader :client
  end
end
