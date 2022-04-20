# frozen_string_literal: true

module Mimitabu
  class Feature
    class Runner
      attr_reader :output_step_results

      def initialize(configuration)
        @configuration = configuration
        @premise_step_results = {}
        @condition_step_results = {}
        @output_step_results = []
      end

      def add_premise_step_result(key, value)
        @premise_step_results[key] = value
      end

      def fetch_premise_step_result(key)
        @premise_step_results[key]
      end

      def add_condition_step_result(key, value)
        @condition_step_results[key] = value
      end

      def fetch_condition_step_result(key)
        @condition_step_results[key]
      end

      def add_output_step_result(value)
        @output_step_results << value
      end
    end
  end
end
