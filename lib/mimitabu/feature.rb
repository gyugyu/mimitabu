# frozen_string_literal: true

require_relative "feature/case"
require_relative "feature/runner"

module Mimitabu
  class Feature
    attr_reader :file, :cases, :result

    def initialize(file, data)
      @file = file
      @data = data
      @cases = data[:cases].map do |kase|
        Case.new(kase.transform_keys(recursive: true, &:to_sym))
      end
    end

    def name
      @data[:feature]
    end

    def compile(support_code)
      @cases.each do |kase|
        kase.compile(support_code)
      end
    end
  end
end
