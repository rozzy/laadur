require 'laadur/version'
require 'optparse'

module Laadur
  class CLI
    def initialize      
      @@HOME = "#{Dir.home}/.laadur"
      Dir.mkdir(File.join(Dir.home, ".laadur"), 0700) if not File.directory? @@HOME

      @@WORKPATH = Dir.pwd
      puts "Your laadur folder is empty.\n\n" if Dir[File.join(@@HOME, '**', '*')].count { |dir| File.directory?(dir) } == 0
      begin
        error_flag ||= false
        options = {}
        OptionParser.new do |opts|
          opts.banner = "Usage: laadur [options]"
          
          opts.on("-v", "--version", "show version") do |v|
            puts Laadur::VERSION
          end

          opts.on("-h", "--help", "help window") do
            puts opts
          end

          opts.on("-f", "--folder", "print folder path") do
            puts @@HOME
          end

          opts.on("-o", "--open", "open laadur folder") do
            `open #{@@HOME}`
          end

          opts.on("-t", "--template <template>", "load template from repository") do |template| 
            p File.directory? "#{@@HOME}/#{template}"
          end

          puts opts if error_flag or ARGV.size == 0

        end.parse!
      rescue OptionParser::InvalidOption => error
        puts error.to_s
        error_flag = true
        retry
      end
    end
  end
end