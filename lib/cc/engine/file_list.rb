require "pathname"

module CC
  module Engine
    class FileList
      include Enumerable

      def initialize(include_paths)
        @include_paths = include_paths
      end

      def each(&block)
        included_files.each(&block)
      end

      private

      attr_reader :include_paths

      def included_files
        include_paths.
          map { |path| make_relative(path) }.
          map { |path| collect_files(path) }.flatten.compact
      end

      def collect_files(path)
        if File.directory?(path)
          Dir.entries(path).map do |new_path|
            next if [".", ".."].include?(new_path)
            collect_files File.join(path, new_path)
          end
        else
          path
        end
      end

      def make_relative(path)
        if path.match(%r(^\./))
          path
        else
          "./#{path}"
        end
      end
    end
  end
end
