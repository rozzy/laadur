require 'laadur/version'
require 'optparse'
require 'fileutils'
require 'shell'

module Laadur
  class CLI
    def initialize
      @@home = "#{Dir.home}/.laadur"
      Dir.mkdir(File.join(Dir.home, ".laadur"), 0700) if not File.directory? @@home

      @@workpath = Dir.pwd
      puts "Your laadur folder is empty.\n\n" if Dir[File.join(@@home, '**', '*')].count { |dir| File.directory?(dir) } == 0
      begin
        error_flag ||= false
        @use_home = false
        @target = @@workpath
        options = {}
        begin
        OptionParser.new do |opts|
          opts.banner = "Usage: laadur [options]"
          
          opts.on("-v", "--version", "show version") do |v|
            puts Laadur::VERSION
          end

          opts.on("-h", "--help", "help window") do
            puts opts
          end

          opts.separator ""

          opts.on("-f", "--folder", "print folder path") do
            puts @@home
          end

          opts.on("-o", "--open", "open laadur folder with Terminal.app") do
            `open #{@@home}`
          end

          opts.separator ""

          opts.on("--home", "point this flag to specify target path from HOME directory (#{@@workpath} by default)") do
            puts "Using #{Dir.home}/ as root."
            @target = Dir.home
            @use_home = true
          end

          opts.on("--target <path>", "specify target folder for copying template files (also see --home)") do |target|
            @target = @use_home ? "#{Dir.home}/#{target}" : "#{@@workpath}/#{target}"
            begin
              puts "Trying to set target to #{@target}, but there is no such folder."
              Dir.mkdir @target
              puts "#{@target} was created."
            end if not File.directory? @target
          end

          opts.on("--prt", "print the path where files will be copied") do
            puts "Files will be copied to: #{@target}"
          end

          opts.separator ""

          opts.on("-t", "--template <template>", "load template from repository") do |template| 
            self.parse_template template
          end

          opts.on("--remove <template>", "remove a certain template") do |template|
            self.remove_template template
          end

          puts opts if error_flag or ARGV.size == 0

        end.parse!
        rescue => error
          puts error.to_s.slice(0,1).capitalize + error.to_s.slice(1..-1)
        end
      rescue OptionParser::InvalidOption => error
        puts error.to_s
        error_flag = true
        retry
      end
    end

    def template? template
      File.directory? "#{@@home}/#{template}"
    end

    def parse_template template
      p template
    end

    def remove_template template
      if self.template? template
        def b(text) "#{`tput bold`}#{text}#{`tput sgr0`}"; end
        print "You asked to remove template #{b template} (#{@@home}/#{template}). Are you sure? [y/n] "
        begin 
          FileUtils.rm_rf "#{@@home}/#{template}" rescue puts "Something went wrong."
        end if gets.chomp! == "y"
      else
        puts "There is no template with such name."
      end
    end
  end
end