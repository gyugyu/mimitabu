# frozen_string_literal: true

require_relative "case/condition"
require_relative "case/output"
require_relative "case/premise"

module Mimitabu
  class Feature
    class Case
      attr_reader :premises, :conditions, :outputs, :results

      def initialize(data)
        @premises = data[:premises].map do |premise|
          Premise.new(premise.transform_keys(recursive: true, &:to_sym))
        end
        @conditions = data[:conditions].map do |condition|
          Condition.new(condition.transform_keys(recursive: true, &:to_sym))
        end
        @outputs = data[:outputs].map do |output|
          Output.new(output.transform_keys(recursive: true, &:to_sym))
        end
      end

      def compile(support_code)
        @premises.each do |premise|
          premise.compile(support_code)
        end
        @conditions.each do |condition|
          condition.compile(@premises, support_code)
        end
        @outputs.each do |output|
          output.compile(@premises, @conditions, support_code)
        end
      end

      def run(runner)
        @premises.each do |premise|
          premise.run(runner)
        end
        @conditions.each do |condition|
          condition.run(runner)
        end
        @results = @outputs.map do |output|
          output.run(runner)
          runner.output_step_results
        end
      end
    end
  end
end
