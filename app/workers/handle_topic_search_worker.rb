# frozen_string_literal: true

module Workers
  class HandleTopicSearchWorker < Workers::BaseWorker
    sidekiq_options retry: 2

    def perform(topic_id, current_time)
      @count = 0
      topic = Topic.find(topic_id)
      since_id = topic.statistics.last&.since_id

      loop do
        result = search(topic.name, since_id)
        current_count = result.size
        since_id = (result.last || {}).fetch(:id_str, '0')
        @count += (current_count || 0)
        break if current_count < 100
      end

      last_tweet = search(topic.name, since_id, 1).first
      since_id = (last_tweet || {}).fetch(:id_str, '0')

      Statistic.create!(
        topic_id: topic_id,
        done_at: current_time,
        count: @count,
        since_id: since_id
      )
    end

    private

    def search(term, since_id, count = 100)
      (client.search(
        term, since_id: since_id, count: count, result_type: 'recent'
      ).to_h || {}).fetch(:statuses, [])
    end

    def client
      ::Clients::Twitter.instance
    end
  end
end
