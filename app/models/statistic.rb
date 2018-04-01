class Statistic < ApplicationRecord
  belongs_to :topic
  scope :by_date, ->(date) { where(done_at: (date - 1.hour)..date) }

  delegate :name, to: :topic, prefix: true

  def as_json(options = {})
    custom_response = {
      topic: topic_name,
      count: count
    }
    options.empty? ? custom_response : super
  end
end
