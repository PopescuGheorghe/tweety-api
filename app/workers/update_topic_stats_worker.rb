module Workers
  class UpdateTopicStatsWorker
    include Sidekiq::Worker
    sidekiq_options retry: 2

    def perform(topic_id)
      topic = Topic.find(topic_id)
      last_tweet = ::Clients::Twitter.instance.search(topic.name, count: 1).first
      since_id = last_tweet.id.to_s if last_tweet
      Statistic.create!(topic_id: topic_id, since_id: since_id)
    end
  end
end
