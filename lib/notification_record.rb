require 'redis'

class NotificationRecord
  def self.store(notification)
    push_to_list('notifications', notification)
  end

  def self.retrieve_last
    retrieve_last_from_list('notifications')
  end

  private

  def self.redis
    Redis.new
  end

  def self.push_to_list(list, item)
    redis.lpush(list, item.to_json)
  end

  def self.retrieve_last_from_list(list)
    JSON.parse(redis.lrange(list, 0, 0)[0])
  end
end