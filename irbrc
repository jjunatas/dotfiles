ANSI_RESET  = "\033[0m"
ANSI_RED    = "\033[31m"
ANSI_BLUE   = "\033[34m"
ANSI_CYAN  = "\033[36m"
ANSI_GREEN  = "\033[32m"
ANSI_YELLOW = "\033[33m"

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
  
  def print_methods(*options)
    ppm self,* options 
  end
  
  def ppm(*options)
    print_methods(*options)
  end
end

def load_railsrc(path)
  load path if File.exists?(path)
end

# if $0 == 'irb' && ENV['RAILS_ENV']
if $0 == 'script/rails'
  load_railsrc( File.expand_path('~/.railsrc') )
  # load_railsrc( File.join(File.dirname(__FILE__), '.railsrc') )
end

# Load the readline module.
IRB.conf[:USE_READLINE] = true

# Remove the annoying irb(main):001:0 and replace with >>
IRB.conf[:PROMPT_MODE]  = :SIMPLE

# Automatic Indentation
IRB.conf[:AUTO_INDENT]=true

# Save History between irb sessions
require 'irb/completion'
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 300
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# Clear the screen
def clear
	system 'clear'
  # if ENV['RAILS_ENV']
  #   return "Rails environment: " + ENV['RAILS_ENV']
  # else
  #   return "No rails environment - happy hacking!";
  # end
end

# Shortcuts
alias c clear

# Load / reload files faster
# http://www.themomorohoax.com/2009/03/27/irb-tip-load-files-faster
def fl(file_name)
   file_name += '.rb' unless file_name =~ /\.rb/
   @@recent = file_name 
   load "#{file_name}"
end

# # #
# loggers

# require 'logger'
# if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
#   Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
# end

def db_logs(switch=:on)
  if switch == :on
    enable_logger
    "Turned on DB console logging"
  else
    disable_logger
    "Turned off DB console logging"
  end
end

def enable_logger
  log_to Logger.new( STDOUT )
end

def disable_logger
  log_to Logger.new( File.join( Rails.root, 'log', 'development.log' ) )
end

def log_to( logger )
  ActiveRecord::Base.logger = logger
  ActiveRecord::Base.clear_active_connections!
end
 
# # logging into console by default
# enable_logger

# # # 
# named routes and helpers

include Rails.application.routes.url_helpers
default_url_options[:host] = Rails.application.class.parent_name.downcase

# # #
# plain sql

def sql(query)
  ActiveRecord::Base.connection.select_all(query)
end

def ppm(obj, *options) # Print methods
  methods = obj.methods
  methods -= Object.methods unless options.include? :more
  filter = options.select {|opt| opt.kind_of? Regexp}.first
  puts filter
  methods = methods.select {|name| name =~ filter} if filter

  data = methods.sort.collect do |name|
    method = obj.method(name)
    if method.arity == 0
      args = "()"
    elsif method.arity > 0
      n = method.arity
      args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")})"
    elsif method.arity < 0
      n = -method.arity
      args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")}, ...)"
    end
    klass = $1 if method.inspect =~ /Method: (.*?)#/
    [name, args, klass]
  end
  max_name = data.collect {|item| item[0].size}.max
  max_args = data.collect {|item| item[1].size}.max
  data.each do |item| 
    print "#{ANSI_CYAN}#{item[0].rjust(max_name)}#{ANSI_RESET}"
    print "#{ANSI_GREEN}#{item[1].ljust(max_args)}#{ANSI_RESET}"
    print "#{ANSI_RED}#{item[2]}#{ANSI_RESET}\n"
  end
  
  data.size
end