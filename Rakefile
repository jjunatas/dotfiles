require 'erb'

def generate_or_symlink(file, options={})
  extname = File.extname(file)
  is_erb = (extname =~ /^\.erb/i)
  is_dir = File.directory?(file)
  basename = File.basename(file, (is_erb ? extname : ''))
  dotfile = is_dir ? "#{ENV['HOME']}/#{basename}" : "#{ENV['HOME']}/.#{basename}"
  dotfile_short = is_dir ? "~/#{basename}" : "~/.#{basename}"
  if File.exist?(dotfile) || File.symlink?(dotfile)
    if options[:force]
      File.delete dotfile
      info "Deleted #{dotfile_short}"
    else
      warning "Not replacing existing #{dotfile_short}"
      return
    end
  end

  if is_erb
    generated_file = File.join( File.expand_path( File.dirname(__FILE__) ), "#{basename}-generated" )
    File.open generated_file, 'w' do |f|
      f.write ERB.new(File.read(file)).result
    end
    success "Generated #{File.basename(generated_file)} from #{File.basename(file)}"
    File.symlink generated_file, dotfile
    success "  Symlinked #{dotfile_short} to #{File.basename(generated_file)}"
  else
    begin
      File.symlink file, dotfile
    rescue NotImplementedError
      warning 'Symlinks are not supported on your system'
      File.open dotfile, 'w' do |f|
        f.write File.read(file)
      end
      success "Copied to #{dotfile_short} from #{basename}"
    else
      success "Symlinked #{dotfile_short} to #{basename}"
    end
  end
end

def info(message)
  puts "*** #{message}"
end

def setup(options={})
  Dir.glob("#{File.dirname __FILE__}/*") do |entry|
    if (File.expand_path(entry) == File.expand_path(__FILE__)) ||
       (File.extname(entry).downcase == '.markdown')           ||
       (File.basename(entry).include?('-generated'))
      next
    end

    generate_or_symlink entry, options
  end
end

def success(message)
  puts "\x1b[32m*** #{message}\x1b[0m"
end

def warning(message)
  puts "\x1b[31m*** #{message}\x1b[0m"
end

desc "Create symbolic links and generate files in #{ENV['HOME']} without overwriting existing files"
task :setup do
  setup
end

desc "Create symbolic links and generate files in #{ENV['HOME']} without overwriting existing files"
task '' => :setup

namespace :setup do
  desc "Delete and recreate symbolic links and generated files in #{ENV['HOME']}"
  task :force do
    setup :force => true
  end
end

task :default => :setup
