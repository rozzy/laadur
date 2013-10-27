require 'laadur/version'
require 'optparse'
require 'fileutils'

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
            self.parse_template template
          end

          opts.on("--remove <template>", "remove a certain template") do |template|
            self.remove_template template
          end

          puts opts if error_flag or ARGV.size == 0

        end.parse!
      rescue OptionParser::InvalidOption => error
        puts error.to_s
        error_flag = true
        retry
      end
    end

    def template? template
      File.directory? "#{@@HOME}/#{template}"
    end

    def parse_template template
      p self.template? template
    end

    def remove_template template
      if self.template? template
        def b(text) "#{`tput bold`}#{text}#{`tput sgr0`}"; end
        print "You asked to remove template #{b template} (#{@@HOME}/#{template}). Are you sure? [y/n] "
        begin 
          FileUtils.rm_rf "#{@@HOME}/#{template}" rescue puts "Something went wrong."
        end if gets.chomp! == "y"
      else
        puts "There is no template with such name."
      end
    end
  end
end