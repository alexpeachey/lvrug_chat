class Publisher

  attr_accessor :config

  def initialize
    @config = {}
    yaml = YAML.load_file(File.join(Rails.root,'config','faye.yml'))[Rails.env]
    raise ArgumentError, "The #{Rails.env} environment does not exist in faye.yml" if yaml.nil?
    yaml.each { |k, v| config[k.to_sym] = v }
  end

  def publish(channel, message)
    client = Faye::Client.new(config[:faye_url])
    client.publish(channel, message)
  end

end