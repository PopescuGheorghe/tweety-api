module Workers
  class TwitterSearchWorker
    include Sidekiq::Worker
    sidekiq_options retry: 2

    def perform(*)
      Topic.find_each do |topic|
        ::Workers::HandleTopicSearchWorker.perform_async(topic.id)
      end
    end
  end
end
