# frozen_string_literal: true

module Workers
  class TwitterSearchWorker < Workers::BaseWorker
    def perform(*)
      current_time = Time.current
      Topic.find_each do |topic|
        ::Workers::HandleTopicSearchWorker.perform_async(topic.id, current_time)
      end
    end
  end
end
