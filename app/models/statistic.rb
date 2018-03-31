class Statistic < ApplicationRecord
  belongs_to :topic
  scope :by_date, ->(date) { where(done_at: (date - 1.hour)..date) }

  def as_json(options = {})
    custom_response = {
      topic: topic.name,
      count: count
    }
    options.empty? ? custom_response : super
  end
end
