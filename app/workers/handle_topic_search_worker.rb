module Workers
  class HandleTopicSearchWorker
    include Sidekiq::Worker
    sidekiq_options retry: 2

    def perform(topic_id)
      current_time = Time.now
      topic = Topic.find(topic_id)
      since_id = topic.statistics.last&.since_id || 0
      count = Clients::Twitter.instance.search(topic.name, since_id: since_id).count
      last_tweet = Clients::Twitter.instance.search(
        topic.name, since_id: since_id, count: 1
      ).first
      since_id = last_tweet.id.to_s if last_tweet
      Statistic.create!(
        topic_id: topic_id,
        done_at: current_time,
        count: count,
        since_id: since_id
      )
    end
  end
end
