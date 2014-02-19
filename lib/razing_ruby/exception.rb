class Exception
  attr_reader :call_binding

  def raze_initialize(*a, &b)
    # Find the calling location
    expected_file, expected_line = caller(1).first.split(':')[0,2]
    expected_line = expected_line.to_i
    return_count = 5  # If we see more than 5 returns, stop tracing

    # Find our caller in the midst of the trace
    find_binding = Proc.new do |event, file, line, id, binding, kls|
      if file == expected_file && line == expected_line
        # Found it: Save the binding and stop tracing
        @call_binding = binding
        unset_trace_func(find_binding)
      end

      if event == :return
        # Seen too many returns, give up. :-(
        unset_trace_func(find_binding) if (return_count -= 1) <= 0
      end
    end

    # Start tracing until we see our caller.
    set_trace_func(find_binding)
    ruby_initialize(*a, &b)
    set_backtrace(caller(3))

    # Hitup our exception handlers
    Kernel.raze_raise_funcs.each { |p| p.call(self) }
  end

  def call_variables
    eval('local_variables.reduce({}) { |o, l| o.merge(l => eval("#{l}")) }', call_binding)
  end

  alias_method :ruby_initialize, :initialize
  alias_method :initialize, :raze_initialize
end
