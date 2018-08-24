require 'json'

module Importer
  # ImporterInterface is a common logic to use through all
  # implemented importers
  module ImporterInterface
    def initialize(file_path, data_store)
      @file_path = file_path
      @data_store = data_store
    end

    def import
      return unless block_given?
      File.readlines(@file_path).each do |line|
        parsed_line = parse_line(line)
        next if parsed_line.nil?
        object = yield(parsed_line)
        next if object.nil?
        @data_store.add(object)
      end
    end

    def parse_line(line)
      JSON.parse(line)
    rescue JSON::ParserError
      puts "#{line} is not formatted correctly"
    end
  end
end
