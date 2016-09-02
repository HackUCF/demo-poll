class Option < ApplicationRecord
  validates :title, presence: true
  has_many :votes
  belongs_to :poll

  def score
    score = 0
    
    self.votes.each do |v|
      score += v.weight
    end

    return score
  end
end
