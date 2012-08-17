class BunnyRabbit
  class << self
    def publish message, opts = {}
      exchange.publish message, opts
    end

    def connect!
      return if connection.connected?
      raise Exception.new("NOT CONNECTED, connecting? #{connection.connecting?}")
    end

    def close
      return unless @connnection
      @connnection.stop
      @connnection = nil
    end

    private
    def connection
      @connection ||= begin
                        puts "Connecting bunny to: #{CONFIG.rabbit.broker.url}"
                        Bunny.new(CONFIG.rabbit.broker.url).tap { |conn| conn.start }
                      end
    end

    def exchange
      @exchange ||= begin
                      exchange = CONFIG.rabbit.outbound.exchange
                      connection.exchange exchange.name, exchange.opts
                    end
    end
  end
end

BunnyRabbit.connect!
at_exit { BunnyRabbit.close }
