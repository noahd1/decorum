require "json"
require "cc/engine/file_list"
require "cc/engine/profanity_finder"

module CC
  module Engine
    class Decorum
      def initialize(code, engine_config, seed_dictionary, io)
        @code = code
        @engine_config = engine_config || {}
        @seed_dictionary = seed_dictionary
        @io = io
      end

      def run
        Dir.chdir(@code) do
          file_list.each do |path|
            inspect_file(path)
          end
        end
      end

      private

      def file_list
        FileList.new(include_paths)
      end

      def include_paths
        @engine_config.fetch("include_paths", ["./"])
      end

      def inspect_file(file)
        ProfanityFinder.new(file, @seed_dictionary).each do |result|
          emit_issue(file, result)
        end
      end

      def emit_issue(file, result)
        @io.print(issue_json(file, result) + "\0")
      ensure
        return
      end

      def issue_json(file, result)
        {
          type: "Issue",
          check_name: "profanity",
          description: "Naughty language! \"#{result.profanity}\" is not allowed in source code.",
          content: { body: profanity_issue_body },
          categories: ["Style"],
          remediation_points: 50_000,
          location: {
            path: local_path(file),
            positions: result.to_hash,
          },
        }.to_json
      end

      def local_path(path)
        realpath = Pathname.new(@code).realpath.to_s
        path.gsub(%r{^#{realpath}/}, '')
      end

      def profanity_issue_body
        "You really, really shouldn't say that Hal."
      end
    end
  end
end
