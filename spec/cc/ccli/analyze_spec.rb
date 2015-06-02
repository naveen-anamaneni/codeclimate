require "spec_helper"
require "cc/cli"

module CC::CLI
  describe Analyze do
    it "handles missing .codeclimate.yml" do
      stub_filesystem do
        analyze = Analyze.new
        analyze.run
      end
    end

    def stub_filesystem(files = {}, &block)
      CC::Analyzer::Filesystem.stub(:new, StubFilesystem.new(files), &block)
    end

    class StubFilesystem
      def initialize(files)
        @files = files
      end

      def read_path(path)
        if @files.key?(path)
          @files[path]
        else
          raise Errno::ENOENT, path
        end
      end

      # implement as needed
      # def source_buffer_for; end
      # def file_paths; end
    end
  end
end
