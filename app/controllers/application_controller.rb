class ApplicationController < ActionController::Base


  def nav_tab(internal_name, display_name, active: false)
    render_to_string('_nav_tab', locals: {
        internal_name: internal_name,
        display_name:  display_name,
        active:        active,
    })
  end

end
