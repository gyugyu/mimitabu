# frozen_string_literal: true

require "erb"

module Mimitabu
  class Formatter
    class HTML
      def initialize(configuration)
        @configuration = configuration
      end

      def create(feature)
        cases = feature.cases.map do |kase|
          [kase.conditions.map(&:with).flatten, kase.results.flatten].transpose
        end

        data = template.result(binding)
        dirname = File.dirname(feature.file)
        basename = File.basename(feature.file, ".*")
        file = "#{dirname.gsub("/", "_")}_#{basename}.html"
        File.write(File.expand_path(file, @configuration.output_dir), data)
      end

      private

        def template
          @template ||= ERB.new(File.read(File.expand_path("templates/feature.html.erb", __dir__)))
        end
    end
  end
end
