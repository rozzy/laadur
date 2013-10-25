require "laadur/version"
require 'optparse'
module Laadur
  class CLI
    def initialize
      o = OptionParser.new do |o|
        o.banner  = "Available options: "
        o.on('-o', '--option', String, 'this option does nothing ') do
          p "option:"<<ARGV[0].to_s
        end
        o.on('-s', '--set', String, 'this option does nothing ') do
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