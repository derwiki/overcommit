module Overcommit
  module Utils
    class << self
      include ConsoleMethods

      def hook_name
        File.basename($0).tr('-', '_')
      end

      def load_hooks
        require File.expand_path("../hooks/#{hook_name}", __FILE__)
      rescue LoadError
        error "No hook definition found for #{hook_name}"
        exit 1
      end

      def script_path(script)
        File.join(File.expand_path('../../hooks/scripts', $0), script)
      end

      # Shamelessly stolen from:
      # http://stackoverflow.com/questions/1509915/converting-camel-case-to-underscore-case-in-ruby
      def underscorize(str)
        str.gsub(/::/, '/').
            gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
            gsub(/([a-z\d])([A-Z])/, '\1_\2').
            tr('-', '_').
            downcase
      end
    end
  end
end