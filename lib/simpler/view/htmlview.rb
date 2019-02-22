require 'erb'
require_relative 'baseview'

class HtmlView < BaseView

  def render(binding)
    template = File.read(template_path)
    @env['simpler.render_view'] = "#{[controller.name, action].join('/')}.html.erb"
    ERB.new(template).result(binding)
  end
end
