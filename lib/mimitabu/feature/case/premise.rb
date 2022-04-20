# frozen_string_literal: true

module Mimitabu
  class Feature
    class Case
      class Premise
        def initialize(data)
          @data = data
        end

        def compile(support_code)
          @steps = support_code.step_definitions.select do |step_definition|
            step_definition.match?(step)
          end
        end

        def run(runner)
          @steps.each do |a_step|
            result = a_step.run
            runner.add_premise_step_result(tag, result)
          end
        end

        def tag
          @data[:tag]
        end

        def step
          @data[:step]
        end
      end
    end
  end
end
