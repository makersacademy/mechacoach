module SlackNotifications
  class SlackNotificationError < StandardError
    attr_reader :code, :body

    def initialize(code, body)
      @code = code
      @body = body
    end

    def message
      "#{@code}: #{@body}"
    end
  end

  class DefaultError < SlackNotificationError
    def message
      "Please update slack_notifier in /lib with this error: #{@code}: #{@body}"
    end
  end

  class ChannelNotFoundError < SlackNotificationError
  end

  class NoTextError < SlackNotificationError
  end
end
