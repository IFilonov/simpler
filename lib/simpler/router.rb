require_relative 'router/route'

module Simpler
  class Router

    def initialize
      @routes = []
    end

    def get(path, route_point)
      add_route(:get, path, route_point)
    end

    def post(path, route_point)
      add_route(:post, path, route_point)
    end

    def route_for(env)
      method = env['REQUEST_METHOD'].downcase.to_sym
      path = env['PATH_INFO']

      @routes.find { |route| route.match?(method, path) }
    end

    private

    def add_route(method, path, route_point)
      route_point = route_point.split('#')
      controller = controller_from_string(route_point[0])
      action = route_point[1]
      route = Route.new(method, path(path), controller, action, param_name(path))
      @routes.push(route)
    end

    def controller_from_string(controller_name)
      Object.const_get("#{controller_name.capitalize}Controller")
    end

    private

    def param_name(path)
      param = path.split('/').last
      param[1..-1] if param.include?(':')
    end

    def path(path)
      path.index(':') ? path[0..path.rindex('/')] : path
    end

  end
end
