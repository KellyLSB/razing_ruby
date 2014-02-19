require 'logger'

class Logger
  def add_logger(*a)
    @logdev.add_logger(*a)
  end

  def del_logger(*a)
    @logdev.del_logger(*a)
  end

  def get_logger(*a)
    @logdev.get_logger(*a)
  end

  def get_loggers
    @logdev.loggers
  end

  class LogDevice
    attr_reader :loggers

    # Create the logger cache
    def raze_initialize(*a, &b)
      ruby_initialize(*a, &b)
      @loggers ||= {}
    end

    # Write a log
    def raze_write(*a, &b)
      results = [ruby_write(*a, &b)]
      @devs.keys.reduce(results) do |out, logger|
        logger.respond_to?(:write) ? out << logger.write(*a, &b) : out
      end
    end

    # Add a logger
    def add_logger(name, logger = nil)
      name, logger = __prep_logger__(name, logger)
      @loggers[name] = logger
    end

    # Remove a logger
    def del_logger(name)
      @loggers[name].close
      @devs.delete(name)
    end

    # Get a logger
    def get_logger(name)
      @loggers[name]
    end

    # Swap the methods with the raze ones
    alias_method :ruby_initialize, :initialize
    alias_method :initialize, :raze_initialize
    alias_method :ruby_write, :write
    alias_method :write, :raze_write

    private

    # Get the logger for the consumption
    def __prep_logger__(name, logger = nil)
      if name.is_a?(String) && ! logger.nil?
        [name, logger.class <= Logger ? logger : Logger.new(logger)]
      elsif name.class <= Logger && logger.nil?
        [name, name]
      else
        [name, Logger.new(name)]
      end
    end
  end
end
