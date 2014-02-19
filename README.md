# RazingRuby

Extends system level debug tools to help you find bugs both in development and production.

## Installation

Add this line to your application's Gemfile:

    gem 'razing_ruby', require: ['razing_ruby/kernel', 'razing_ruby/exception']

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install razing_ruby

## Usage

### razing_ruby/kernel

**Kernel#set_trace_func**

You can add additional **Kernel#set_trace_func** handlers by running `set_trace_func multiple` times; which will return the index to remove it later with **Kernel#unset_trace_func_index**.

`set_trace_func` also now accepts a block or a proc argument with the argument taking precendence.

### razing_ruby/exception (requires kernel automatically)

**Kernel#set_raise_func**

You can now add additional **Kernel#raise** handlers! When you use `set_raise_func`; which operates just as `set_trace_func` above; you can now handle exceptions with multiple providers. This is useful if you want to send every exception to Graylog 2 or Airbrake. It also means you will be able to send more exceptions since it integrates directly into Kernel#raise!

### razing_ruby/logger

This adds multi logging capabilities. On any Logger object the following methods are avaiable.

**Logger#add_logger(name[, logger])**

Adds a logger to this logger to be simoultaneously logged

- Name: Identifier of the logger or an Logger object (or filename).
- Logger: Logger or filename if name is used as an identifier.

**Logger#del_logger(name)**

Removes a logger for the additional logger pool

- Name: Identifier or the Logger object you would like to remove (you can only remove by object if you passed object into the name attribute in add_logger)

**Logger#get_logger(name)**

Get a logger by name

- Name: Identifier or the Logger object you would like to access (you can only access by object if you passed object into the name attribute in add_logger; but why would you?)

**Logger#get_loggers**

Return all the registered loggers

## Contributing

1. Fork it ( http://github.com/<my-github-username>/razing_ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
