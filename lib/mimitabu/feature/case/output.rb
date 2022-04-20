# frozen_string_literal: true

module Mimitabu
  class Feature
    class Case
      class Output
        def initialize(data)
          @data = data
        end

        def compile(premises, conditions, support_code)
          return if @data[:require].nil?
          requirement = conditions.find { |premise| premise.tag == requirement_tag }
          raise if requirement.nil?
        end

        def run(runner)
          pre = runner.fetch_condition_step_result(requirement_tag)
          result = pre.each do |p|
            obj = [[requirement_tag.to_sym, p]].to_h
            run_single(obj)
          end
          runner.add_output_step_result(result)
        end

        private

          def requirement_tag
            @data[:require].split('.')[1]
          end

          def run_single(obj)
            binding.eval(@data[:run])
          end
      end
    end
  end
end
