require 'optparse'
require './runners/user'

OFFICE = [53.339428, -6.257664].freeze
MAX_DISTACE = 100.0
FILE_PATH = './customers.txt'.freeze

HELP_TEXTS = {
  help: 'Print this help',
  file: 'relative file path include customers data (default ./customers.txt)',
  distance: 'max aloowed distance from the origin (default 100)',
  origin: 'origin point 2 numbers seperated by , (default 53.339428, -6.257664)'
}.freeze

OptionParser.new do |opt|
  opt.banner = 'Usage: run.rb [options]'

  opt.on('-h', '--help', HELP_TEXTS[:help]) do
    puts opt
    exit
  end

  opt.on('-f FILE', '--file FILE', HELP_TEXTS[:file]) do |file_path|
    @file_path = file_path
  end

  opt.on('-d DISTANCE',
         '--distance DISTANCE',
         HELP_TEXTS[:distance]) do |max_distance|
    @max_distance = max_distance.to_f
  end

  opt.on('-o ORIGIN', '--origin ORIGIN', HELP_TEXTS[:origin]) do |origin|
    @origin = origin.split(',').map(&:to_f)
  end
end.parse!

puts(Runners::User.new(@file_path || FILE_PATH,
                       @max_distance || MAX_DISTACE,
                       @origin || OFFICE).perform)
