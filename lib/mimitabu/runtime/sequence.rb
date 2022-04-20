# frozen_string_literal: true

module Mimitabu
  class Runtime
    class Sequence
      attr_reader :tag

      def initialize(tag, proc)
        @tag = tag
        @proc = proc
        @value = 1
      end

      def next
        @proc.call(@value)
      ensure
        @value = @value.next
      end
    end
  end
end
