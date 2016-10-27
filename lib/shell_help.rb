require "optparse"
require "shell_help/version"

module ShellHelp
  # Your code goes here...
  class Command
    def self.run(argv)
      new(argv).execute
    end
    
    def initialize(argv)
      @argv=argv
    end
    
    def execute
      command_parser = OptionParser.new do |opt|
        opt.on('-v','--version','Show program version') do |v|
          opt.version = ShellHelp::VERSION
          puts opt.ver
          exit
        end
      end
      
      command_parser.parse!(@argv)
    end
  end


end
