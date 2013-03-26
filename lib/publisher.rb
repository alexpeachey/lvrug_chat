class Publisher

  def publish(channel, message)
    client = Faye::Client.new(FAYE_URL)
    client.add_extension(ClientAuth.new)
    client.publish(channel, message)
  end

  class ClientAuth
    def outgoing(message, callback)
      if message['channel'] !~ %r{^/meta/}
        message['ext'] ||= {}
        message['ext']['auth_token'] = FAYE_TOKEN
      end
      callback.call(message)
    end
  end

end
