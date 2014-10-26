class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :race

  validates :user_id, :race_id, :duration, :date, presence: true

  def duration_in_words
    Duration.new(seconds: duration).format("%h:%M:%S")
  end

  def date_in_words
    date.strftime("#{date.day.ordinalize} %b %y")
  end
end
