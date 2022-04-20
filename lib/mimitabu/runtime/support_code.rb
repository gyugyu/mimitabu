# frozen_string_literal: true

module Mimitabu
  class Runtime
    class SupportCode
      def initialize(configuration)
        @configuration = configuration
        @dsl = DSL.new
      end

      def load_files(files)
        files.each do |file|
          @dsl.load_file file
        end
      end

      def step_definitions
        @dsl.step_definitions
      end

      def sequences
        @dsl.sequences
      end
    end
  end
end
