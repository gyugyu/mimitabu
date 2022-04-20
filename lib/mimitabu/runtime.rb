# frozen_string_literal: true

require "yaml"
require_relative "runtime/sequence"
require_relative "runtime/step_definition"
require_relative "runtime/support_code"

module Mimitabu
  class Runtime
    def initialize(configuration = Configuration.default)
      @configuration = configuration
      @support_code = SupportCode.new(configuration)
      @formatter = Formatter.new(configuration)
    end
    
    def run
      load_step_definitions
      features.each do |feature|
        feature.compile(@support_code)
      end
      features.each do |feature|
        feature.cases.each do |kase|
          runner = Feature::Runner.new(@configuration)
          kase.run(runner)
        end
      end
      features.each do |feature|
        @formatter.create(feature)
      end
    end

    private

      def load_step_definitions
        @support_code.load_files(@configuration.step_definition_files)
      end

      def features
        @features ||= @configuration.feature_files.map do |file|
          data = ::YAML.safe_load File.read(file)
          Feature.new(file, data.transform_keys(recursive: true, &:to_sym))
        end
      end
  end
end
