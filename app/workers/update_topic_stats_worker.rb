module Workers
  class UpdateTopicStatsWorker
    include Sidekiq::Worker

    def perform(topic_id)
      topic = Topic.find(topic_id)
      last_tweet = Clients::Twitter.instance.search(topic.name, count: 1).first
      Statistic.create!(topic_id: topic_id, since_id: last_tweet.id.to_s)
    end
  end
end
