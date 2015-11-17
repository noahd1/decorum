require "spec_helper"
require "cc/engine/decorum"
require "tmpdir"

module CC::Engine
  describe Decorum do
    before { @code = Dir.mktmpdir }

    describe "#run" do
      it "analyzes ruby files using decorum" do
        create_source_file("foo.rb", <<-EORUBY)
          def method
            unused = "fuck"

            return false
          end
        EORUBY

        output = run_engine

        assert includes_profanity?(output)
      end

      def includes_profanity?(output)
        issues(output).any? { |i| i["check_name"] == "profanity" }
      end

      def issues(output)
        output.split("\0").map { |x| JSON.parse(x) }
      end

      def create_source_file(path, content)
        abs_path = File.join(@code, path)
        FileUtils.mkdir_p(File.dirname(abs_path))
        File.write(abs_path, content)
      end

      def run_engine(config = nil)
        io = StringIO.new
        decorum = Decorum.new(@code, config, ["fuck", "shit"], io)
        decorum.run

        io.string
      end
    end
  end
end
