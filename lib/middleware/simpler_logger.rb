require 'logger'

class SimplerLogger

  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    status, header, body = @app.call(env)
    write_log(env, status, header)
    [status, header, body]
  end

  def write_log(env, status, header)
    @logger.info("Request: #{env['REQUEST_METHOD'].upcase} #{env['REQUEST_URI']};")
    @logger.info("Handler: #{env['simpler.controller_name']}##{env['simpler.action']};")
    @logger.info("Parameters: #{env['simpler.params']}")
    @logger.info("Response: #{status} [#{header}] #{env['simpler.render_view']}")
  end

end
