class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :location

  def duration=(duration)
    case duration
      when String then write_attribute(:duration, ChronicDuration::parse(duration).to_i)
      when Integer then write_attribute(:duration, duration)
      else raise "Unable to parse duration, need String or Integer format : %s", date
    end
  end

  def happen_at=(date)
    case date
      when String then write_attribute(:happen_at, DateTime::strptime(date, "%m/%d/%Y %I:%M %p"))
      when Date then write_attribute(:happen_at, date)
      else raise "Unable to parse date, need String or Date format : %s", date
    end
  end

  def privacy=(privacy)
    if privacy.respond_to? :to_i
      write_attribute(:privacy, privacy)
    else
      if privacy == "private"
        write_attribute(:privacy, 1)
      else
        write_attribute(:privacy, 0)
      end
    end
  end

  validates :title, length: {minimum: 2}, presence: true
  validates :description, presence: true
  validates :happen_at, presence: true
  validates :duration, presence: true
  validates :privacy, presence: true
  validates :location, presence: true
  validates :user, presence: true
end
