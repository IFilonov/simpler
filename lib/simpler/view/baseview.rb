class BaseView

  VIEW_BASE_PATH = 'app/views'.freeze

  def initialize(env)
    @env = env
  end
  
  private

  def template_path
    path = template || [controller.name, action].join('/')

    Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
  end

  def controller
    @env['simpler.controller']
  end

  def action
    @env['simpler.action']
  end

  def template
    @env['simpler.template']
  end
end
