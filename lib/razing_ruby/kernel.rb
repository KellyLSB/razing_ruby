module Kernel
  #####################
  #= Ruby Trace Func =#
  #####################

  def raze_trace_funcs
    @@raze_trace_funcs ||= []
  end

  def raze_set_trace_func(proc = nil, &block)
    return false unless (proc ||= block).is_a?(Proc)
    ruby_set_trace_func(Proc.new{ |*a, &b|
      Kernel.raze_trace_funcs.each { |p| p.call(*a, &b) }
    }) if Kernel.raze_trace_funcs.empty?
    (Kernel.raze_trace_funcs << proc).index(proc)
  end

  def raze_unset_trace_func(proc = nil, &block)
    Kernel.raze_trace_funcs.delete(proc ||= block)
  end

  def raze_unset_trace_func_index(index)
    Kernel.raze_trace_funcs.delete_at(index)
  end

  alias_method :ruby_set_trace_func, :set_trace_func
  alias_method :set_trace_func, :raze_set_trace_func
  alias_method :unset_trace_func, :raze_unset_trace_func
  alias_method :unset_trace_func_index, :raze_unset_trace_func_index
  alias_method :trace_funcs, :raze_trace_funcs

  ################
  #= Ruby Raise =#
  ################

  def raze_raise_funcs
    @@raze_raise_funcs ||= []
  end

  def raze_set_raise_func(proc = nil, &block)
    return false unless (proc ||= block).is_a?(Proc)
    (Kernel.raze_raise_funcs << proc).index(proc)
  end

  def raze_unset_raise_func(proc = nil, &block)
    Kernel.raze_raise_funcs.delete(proc ||= block)
  end

  def raze_unset_raise_func_index(index)
    Kernel.raze_raise_funcs.delete_at(index)
  end

  alias_method :set_raise_func, :raze_set_raise_func
  alias_method :unset_raise_func, :raze_unset_raise_func
  alias_method :unset_raise_func_index, :raze_unset_raise_func_index
  alias_method :raise_funcs, :raze_raise_funcs
end
