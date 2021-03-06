# frozen_string_literal: true

module Workers
  class BaseWorker
    include Sidekiq::Worker
    include Sidekiq::Status::Worker
  end
end
