class Poll < ApplicationRecord
  has_many :options
  has_many :votes
end
