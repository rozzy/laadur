require "laadur/version"

module Laadur
  class CLI
    def initialize
      optparse = OptionParser.new do|opts|
        # TODO: Put command-line options here
        
        # This displays the help screen, all programs are
        # assumed to have this option.
        opts.on( '-h', '--help', 'Display this screen' ) do
          puts opts
          exit
        end
      end
    end
  end
end
