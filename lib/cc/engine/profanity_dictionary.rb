module CC
  module Engine
    class ProfanityDictionary
      include Enumerable

      def initialize(profanities = [])
        @profanities = profanities
      end

      def self.from_file(file)
        self.new(File.read(file).split(/\n/))
      end

      def +(more)
        @profanities += more
      end

      def each(&block)
        list.each(&block)
      end

      private

      def list
        @profanities.compact.uniq
      end
    end
  end
end
