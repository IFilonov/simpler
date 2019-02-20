module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :param_name, :method, :path

      def initialize(method, path, controller, action, param_name)
        @param_name = param_name
        @method = method
        @path = path
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && path.match?(@path)
      end

      def param_nil?
        @param_name == nil
      end

    end
  end
end
