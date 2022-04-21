# frozen_string_literal: true

require_relative "formatter/html"

module Mimitabu
  class Formatter
    def initialize(configuration)
      @configuration = configuration
      @html = Formatter::HTML.new(configuration)
    end

    def create(feature)
      if File.exist?(@configuration.output_dir)
        FileUtils.rm_r(@configuration.output_dir, secure: true)
      end
      FileUtils.mkdir_p(@configuration.output_dir)
      @html.create(feature)
    end
  end
end
