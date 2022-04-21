# frozen_string_literal: true

# freeze_string_literal: true

module Mimitabu
  class Runtime
    class StepDefinition
      attr_reader :sequences

      def initialize(string_or_regexp, options, &proc)
        @haystack = string_or_regexp.is_a?(String) ? string_or_regexp : nil
        @pattern = string_or_regexp.is_a?(Regexp) ? string_or_regexp : nil
        @options = options
        @proc = proc
      end

      def register_sequences(sequences)
        keys = if @options[:sequence].nil?
                 []
               elsif @options[:sequence].is_a? Symbol
                 [@options[:sequence]]
               else
                 @options[:sequence]
               end

        @sequences = sequences.select { |sequence| keys.include? sequence.tag }
      end

      def match?(step)
        return step.include?(@haystack) unless @haystack.nil?
        return @pattern =~ step unless @pattern.nil?

        false
      end

      def run(*args)
        sequence_result = @sequences.to_h { |sequence| [sequence.tag, sequence.next] }
        @proc.call(*(args + [sequence_result]))
      end
    end
  end
end
