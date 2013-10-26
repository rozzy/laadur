require "laadur/version"
require 'optparse'
module Laadur
  class CLI
    def initialize
      @dir = ''
      o = OptionParser.new do |o|
        o.banner  = "Available options: "
        o.on('-o', '--option') do
          p "option:"<<ARGV[0].to_s
        end
        o.on('-f', '--folder') do
          @dir = ARGV[0].to_s
        end
      end

      sp = Dir.home+'/dev'+@dir
      p @dir
      p Dir.glob sp+"/*" if Dir.exists? sp

      begin o.parse! ARGV
      rescue OptionParser::InvalidOption => e
        puts e
        puts o
        exit 1
      end
    end
  end
end