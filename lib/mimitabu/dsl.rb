# frozen_string_literal: true

module Mimitabu
  class DSL
    attr_reader :step_definitions

    def initialize
      @step_definitions = []
      @sequences = []
    end

    def load_file(file)
      instance_eval File.read(file), file
      register_sequences
    end

    def step(stringOrRegexp, **options, &proc)
      @step_definitions << Runtime::StepDefinition.new(stringOrRegexp, options, &proc)
    end

    def sequence(tag, &proc)
      @sequences << Runtime::Sequence.new(tag, proc)
    end

    private

      def register_sequences
        @step_definitions.each do |step_definition|
          step_definition.register_sequences(@sequences)
        end
      end
  end
end
