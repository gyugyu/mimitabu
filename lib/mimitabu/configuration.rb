# frozen_string_literal: true

module Mimitabu
  class Configuration
    class << self
      def default
        new
      end
    end

    def initialize(options = {})
      @options = default_options.merge(options)
    end

    def step_definition_files
      @options[:autoload_code_paths].map { |path| Dir["#{path}/**/*.rb"] }.flatten.uniq
    end

    def feature_files
      @options[:feature_file_paths].map { |path| Dir["#{path}/**/*.yml"] }.flatten.uniq
    end

    def output_dir
      @options[:output_dir]
    end

    private

    def default_options
      {
        autoload_code_paths: ["samplers/step_definitions"],
        feature_file_paths: ["samplers/features"],
        formatter: "html",
        output_dir: "out"
      }
    end
  end
end
