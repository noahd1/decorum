require "cc/engine/profanity_dictionary"

module CC
  module Engine
    class ProfanityFinder
      include Enumerable

      def initialize(file, dictionary = ProfanityDictionary.new)
        @file = file
        @dictionary = dictionary
      end

      def each(&block)
        profanities.each(&block)
      end

      private

      def profanities
        @profanities ||= [].tap do |results|
          begin
            file_contents.split("\n").each_with_index do |line, i|
              @dictionary.each do |bad|
                if pos = line =~ /\b#{bad}\b/i
                  results << Result.new(line_number: i + 1, column: pos + 1, profanity: bad)
                end
              end
            end
          rescue ArgumentError
            STDERR.puts "Nope, dawg. :( #{@file}"
            []
          end
        end
      end

      def file_contents
        File.read(@file)
      end

      class Result
        attr_accessor :line_number, :column, :profanity

        def initialize(line_number:, column:, profanity:)
          @line_number = line_number
          @column = column
          @profanity = profanity
        end

        def column_start
          @column
        end

        def column_end
          @column + @profanity.size
        end

        def to_hash
          {
            begin: {
              column: @column,
              line: @line_number,
            },
            end: {
              column: column_end,
              line: @line_number,
            }
          }
        end
      end
    end
  end
end
