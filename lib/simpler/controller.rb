require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response, :route_params

    def initialize(env, route_param)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @route_param = {}
      @route_param[route_param.to_sym] = route_param_value(env) if route_param
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.controller_name'] = self.class
      @request.env['simpler.action'] = action

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def params
      @request.params.merge!(@route_param)
      @request.env['simpler.params'] = @request.params
      @request.params
    end

    def route_param_value(env)
      path = env['PATH_INFO']
      path.split('/').last
    end

    def render(template)
      if template[:plain]
        @request.env['simpler.text'] = template[:plain]
      else
        @request.env['simpler.template'] = template
      end
    end

    def status(status)
      @response.status = status
    end

    def headers
     @response.headers
    end

  end
end
