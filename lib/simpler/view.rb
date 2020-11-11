require_relative 'view/htmlview'
require_relative 'view/plainview'

module Simpler
  class View

    RENDER_VIEW = {
      html: HtmlView,
      plain: PlainView
    }

    def initialize(env)
      @env = env
      @render_view = @env['simpler.text'] ? RENDER_VIEW[:plain].new(env) : RENDER_VIEW[:html].new(env)
    end

    def render(binding)
      @render_view.render(binding)
    end

  end
end
