Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Logstash.new
  config.lograge.logger = ActiveSupport::Logger.new(STDOUT)

  config.lograge.custom_options = lambda do |event|
    {source_host: 0, user_id: event.payload[:user_id], params: event.payload[:params].except('controller', 'action', 'format', 'utf8')}
  end
end
