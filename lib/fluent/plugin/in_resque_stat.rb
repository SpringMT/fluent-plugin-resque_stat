module Fluent
  class ResqueStatInput < Input
    Plugin.register_input('resque_stat', self)

    def initialize
      super
      require 'resque'
    end

    def initialize
      super
    end

    config_param :tag,          :string
    config_param :host,         :string,  :default => '127.0.0.1'
    config_param :port,         :integer, :default => 6379
    config_param :run_interval, :integer, :default => 60

    def configure(conf)
      super
      Resque.redis = "#{@hosts}:#{@port}"
    end

    def start
      if @run_interval
        @finished = false
        @thread = Thread.new(&method(:run_redis_stat))
      else
        @thread = Thread.new(&method(:run))
      end
    end

    def shutdown
      if @run_interval
        @finished = true
        @thread.join
      else
        @thread.join
      end
    end

    def run
      redis_each_line
    end

    def run_redis_stat
      until @finished
        sleep @run_interval
        redis_each_line
      end
    end

    private
    def redis_each_line
      begin
        record = Redis.info
        tag    = @tag
        if tag
          Engine.emit(tag, Engine.now, record)
        end
      rescue
        $log.error "exec failed to emit", :error=>$!.to_s, :line=>line
        $log.warn_backtrace $!.backtrace
      end
    end

  end
end
