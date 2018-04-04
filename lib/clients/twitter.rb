# frozen_string_literal: true

module Clients
  class Twitter
    include Singleton

    delegate :search, to: :client

    def initialize
      @client ||= ::Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      end
    end

    private

    attr_reader :client
  end
end
