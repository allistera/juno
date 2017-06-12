OkComputer.mount_at = 'health'
OkComputer::Registry.register 'redis_check', OkComputer::RedisCheck.new({})
OkComputer::Registry.register 'sidekiq_latency_check', OkComputer::SidekiqLatencyCheck.new('default')
