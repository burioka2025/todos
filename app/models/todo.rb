class Todo < ApplicationRecord
  belongs_to :project
  accepts_nested_attributes_for :project
  def self.get_random
    result = self.order("RANDOM()").limit(1)
    result.first
  end
end
