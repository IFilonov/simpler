require 'logger'

class SimplerLogger

  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    app_result = @app.call(env)
    write_log(env, app_result)
    app_result
  end

  def write_log(env, app_result)
    @logger.info("Request: #{env['REQUEST_METHOD'].upcase} #{env['REQUEST_URI']};")
    @logger.info("Handler: #{env['simpler.controller_name']}##{env['simpler.action']};")
    @logger.info("Parameters: #{env['simpler.params']}")
    @logger.info("Response: #{app_result[0]} [#{app_result[1]['Content-Type']}] #{env['simpler.render_view']}")
  end

end
