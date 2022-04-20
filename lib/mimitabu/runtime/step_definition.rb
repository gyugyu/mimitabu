# freeze_string_literal: true

module Mimitabu
  class Runtime
    class StepDefinition
      attr_reader :sequences

      def initialize(stringOrRegexp, options, &proc)
        @haystack = (stringOrRegexp.is_a? String) ? stringOrRegexp : nil
        @pattern = (stringOrRegexp.is_a? Regexp) ? stringOrRegexp : nil
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

      def call(*args)
        sequence_result = @sequences.map { |sequence| [sequence.tag, sequence.next] }.to_h
        @proc.call(*(args + [sequence_result]))
      end
    end
  end
end
