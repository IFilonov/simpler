module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @params = params(path)
        @method = method
        @path = path_without_params(path)
        @controller = controller
        @action = action
      end

      def match?(method, path, env)
        match = @method == method &&
          @path == path_by_params_mask(path) &&
          @params.count == split_path_count(path)
        add_params_in_env(env, path) if match
        match
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

      def path_without_params(path)
        split_path(path).map { |item| item unless item.include?(":") }.join("/")
      end

      def path_by_params_mask(path)
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
