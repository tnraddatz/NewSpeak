ENV.each { |k, v| env(k, v) }
set :output, '/var/log/cron.log'
every 1.hour do
  rake "import:news"
end
