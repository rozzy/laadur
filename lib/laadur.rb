require "laadur/version"
require 'optparse'
module Laadur
  class CLI
    def initialize
      sp = Dir.home+'/dev'
      p Dir.glob sp+"/*" if Dir.exists? sp
      o = OptionParser.new do |o|
        o.banner  = "Available options: "
        o.on('-o', '--option') do
          p "option:"<<ARGV[0].to_s
        end
        o.on('-s', '--set') do
          p "set:"<<ARGV[0].to_s
        end
      end
      begin o.parse! ARGV
      rescue OptionParser::InvalidOption => e
        puts e
        puts o
        exit 1
      end
    end
  end
end