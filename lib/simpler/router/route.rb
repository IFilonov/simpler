module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @params = params(path)
        @method = method
        @path = mask_path(path)
        @controller = controller
        @action = action
      end

      def match?(method, path, env)
        add_params_in_env(env, path)
        @method == method && @path == mask(path) && @params.count == split_path_count(path)
      end

      private

      def params(path)
        split_path(path).map { |param| param[1..-1].to_sym if param.include?(":") }
      end

      def add_params_in_env(env, path)
        env['simpler.params'] = params_with_value(path) if @params.any?
      end

      def params_with_value(path)
        path_parts = path.split('/')
        params_values = @params.map.with_index { |param, i| path_parts[i] if @params[i] }
        Hash[@params.compact.zip(params_values.compact)]
      end

      def mask_path(path)
        split_path(path).map { |item| item unless item.include?(":") }.join("/")
      end

      def mask(path)
        path_parts = split_path(path)
        @params.map.with_index { |param, i| path_parts[i] if param.nil?}.join("/")
      end

      def split_path_count(path)
        split_path(path).count
      end

      def split_path(path)
        path.split("/")
      end

    end
  end
end
