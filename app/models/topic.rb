class Topic < ApplicationRecord
  has_many :statistics, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 200 }

  after_create :update_statistic

  def as_json(options = {})
    custom_response = { name: name }
    options.empty? ? custom_response : super
  end

  private

  def update_statistic
    Workers::UpdateTopicStatsWorker.perform_async(id)
  end
end
