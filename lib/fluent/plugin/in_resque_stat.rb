module Fluent
  class ResqueStatInput < Input
    Plugin.register_input('resque_stat', self)

    def initialize
      super
      require 'resque'
    end

    config_param :tag,          :string,  :default => nil
    config_param :host,         :string,  :default => '127.0.0.1'
    config_param :port,         :integer, :default => 6379
    config_param :run_interval, :time,    :default => 60

    def configure(conf)
      super
      if !@tag
        raise ConfigError, "'tag' option is required on exec input"
      end
      Resque.redis = "#{@hosts}:#{@port}"
    end

    def start
      @finished = false
      @thread = Thread.new(&method(:run_resque_stat))
    end

    def shutdown
      @finished = true
      @thread.join
    end

    def run_resque_stat
      until @finished
        sleep @run_interval
        resque_each_line
      end
    end

    private
    def resque_each_line
      begin
        record = Resque.info
        tag    = @tag
        if tag
          Engine.emit(tag, Engine.now, record)
        end
      rescue => e
        $log.error "exec failed to emit", :error=>$!.to_s, :line => e.message
        $log.warn_backtrace $!.backtrace
      end
    end

  end
end
