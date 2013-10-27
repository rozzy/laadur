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
        @parsed_tmpl = false
        @used_target = false
        @target = @@workpath
        options = {}
        loaded = []
        reserved = ['-v', '--version', '-h', '--help', '--docs', '-o', '--open', '-l', '--list', '--folder', '-t', '--target', '--home', '--pwd', '--prt', '-r', '--remove']
        begin
        OptionParser.new do |opts|
          opts.banner = "Usage: laadur [options]"

          opts.on("-v", "--version", "show version") do
            puts version
          end

          opts.on("-h", "--help", "help window") do
            puts opts
          end

          opts.on("--docs", "open github documentation page") do
            `open https://github.com/rozzy/laadur`
          end

          opts.separator ""

          opts.on("-o", "--open", "open laadur folder with Finder.app") do
            `open #{@@home}`
          end

          opts.on("-l", "--list", "list all templates") do
            files = Dir.new(@@home).drop(2) 
            if files.size > 0
              puts "There #{files.size == 1 ? 'is' : 'are'} #{files.size} #{files.size == 1 ? 'template' : 'templates'}:"
              last = files.last
              files.pop
              files.each do |file|
                puts "├ #{b file}"
              end
              puts "└ #{b last}"
            else
              puts "Your laadur folder is empty!"
            end
          end

          opts.on("--folder", "print folder path") do
            puts @@home
          end

          opts.separator ""

          opts.on("-t", "--target <path>", "specify target folder for copying template files (also see --home)") do |target|
            raise "Next time use --target before specifying the template." if @parsed_tmpl
            @target = @use_home ? "#{Dir.home}/#{target}" : "#{@@workpath}/#{target}"
            begin
              puts "Trying to set target to #{@target}, but there is no such folder."
              Dir.mkdir @target
              puts "So #{@target} was created."
              @used_target = true
            end if not File.directory? @target
          end

          opts.on("--home", "use home folder as root for target option (pwd by default)") do
            raise "Next time use --home before specifying the target." if @used_target
            puts "Using #{Dir.home}/ as root."
            @target = Dir.home
            @use_home = true
          end
          
          opts.on("--pwd", "return back home as pwd (useful with multiloading)") do
            puts "Using #{@@workpath}/ as root."
            @target = @@workpath
            @use_home = true
          end
          
          opts.on("--prt", "print target path (where files will be copied)") do
            puts "Files will be copied to: #{@target}"
          end

          opts.separator ""

          #opts.on("load template from repository", "-l", "--load <template>", "you may not specify this flag") do |template| 
          #  self.parse_template template
          #end

          opts.on("-r", "--remove <template>", "remove a certain template") do |template|
            self.remove_template template
          end
          
          if ARGV.size == 0
            File.foreach('laadur.txt') do |line|
              match = line.match /\#\{(.*)\}/
              line = line.gsub /\#\{(.*)\}/, instance_eval("#{match[1]}") if match
              puts line
            end
            puts ""
          end

          if ARGV.size > 0
            ARGV.each do |template|
              if template.match /^--|-/
                if reserved.include? template 
                  if self.template? template
                    puts "There is option with name #{b template} and a path #{@@home}/#{b template}."
                    puts "I think this is option. If you want use it as path, load it like this: /../.laadur/#{b template}. Sorry :-("
                    puts ""
                    puts opts
                    puts ""
                    next
                  else next end
                end
              end

              if self.template? template
                self.parse_template template
              else
                puts "There is no such template: #{b template}. I ignore."
              end
            end
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
      @parsed_tmpl = true
      puts template
    end
    
    def version; File.read "version"; end

    def b(text) "#{`tput bold`}#{text}#{`tput sgr0`}"; end

    def remove_template template
      if self.template? template
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