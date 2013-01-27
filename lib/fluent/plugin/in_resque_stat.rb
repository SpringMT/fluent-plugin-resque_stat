module Fluent
  class ResqueStatInput < Input
    Plugin.register_input('resque_stat', self)

    def initialize
      super
      require 'resque'
    end

    config_param :tag,          :string
    config_param :host,         :string,  :default => '127.0.0.1'
    config_param :port,         :integer, :default => 6379
    config_param :run_interval, :time,    :default => 60

    def configure(conf)
      super
      Resque.redis = "#{@host}:#{@port}"
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
        resque_stat = Resque.info
        record = {}
        resque_stat.each { |key, value| record[key.to_s] = value }
        Engine.emit(@tag, Engine.now, record)
      rescue => e
        $log.error "rescue_stat failed to emit", :error => $!.to_s, :line => e.message
        $log.warn_backtrace $!.backtrace
      end
    end

  end
end
