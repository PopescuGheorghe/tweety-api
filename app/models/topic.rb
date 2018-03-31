class Topic < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { maximum: 200 }

  def as_json(options = {})
    custom_response = { name: name }
    options.empty? ? custom_response : super
  end
end
