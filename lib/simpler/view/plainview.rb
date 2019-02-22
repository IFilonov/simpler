require_relative 'baseview'
class PlainView < BaseView

  def render(binding)
    template = File.read(template_path)
    @env['simpler.render_view'] = "#{[controller.name, action].join('/')}.html.erb"
    @env['simpler.text']
  end
end
