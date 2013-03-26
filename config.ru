# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require 'faye'

class ServerAuth
  def incoming(message, callback)
    if message['channel'] !~ %r{^/meta/}
      if message['ext']['auth_token'] != ENV['FAYE_TOKEN']
        message['error'] = 'Invalid authentication token.'
      end
    end
    callback.call(message)
  end
end

use Faye::RackAdapter, mount: '/faye', timeout: 25, extensions: [ServerAuth.new]

run LvrugChat::Application
