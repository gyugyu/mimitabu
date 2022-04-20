# frozen_string_literal: true

module Mimitabu
  class Feature
    class Case
      class Condition
        def initialize(data)
          @data = data
        end

        def compile(premises, support_code)
          @steps = support_code.step_definitions.select do |step_definition|
            step_definition.match?(step)
          end

          return if @data[:require].nil?
          requirement = premises.find { |premise| premise.tag == requirement_tag }
          raise if requirement.nil?
        end

        def run(runner)
          @steps.each do |step|
            pre = runner.fetch_premise_step_result(requirement_tag) unless @data[:require].nil?
            result = with.map { |w| step.run(pre, with: w) }
            runner.add_condition_step_result(tag, result)
          end
        end

        def tag
          @data[:tag]
        end

        def step
          @data[:step]
        end

        def with
          @data[:with]
        end

        private

          def requirement_tag
            @data[:require].split('.')[1]
          end
      end
    end
  end
end
