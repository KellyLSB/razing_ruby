require 'logger'

class Logger
  attr_reader :logdev

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

    # Write a log
    def raze_write(*a, &b)
      results = [ruby_write(*a, &b)]
      loggers.values.map(&:logdev).reduce(results) do |out, logger|
        logger.respond_to?(:write) ? out << logger.write(*a, &b) : out
      end
    end

    # Add a logger
    def add_logger(name, logger = nil)
      name, logger = __prep_logger__(name, logger)
      return false if logger.logdev == self
      loggers[name] = logger
    end

    # Remove a logger
    def del_logger(name)
      loggers[name].close
      loggers.delete(name)
    end

    # Get a logger
    def get_logger(name)
      loggers[name]
    end

    def loggers
      @loggers ||= {}
    end

    # Swap the methods with the raze ones
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
