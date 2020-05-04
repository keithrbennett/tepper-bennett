module ApplicationHelper

  def external_link(text, url)
    tag.a(text, href:url, target: '_blank').html_safe
  end

  def li_external_link(text, url)
    tag.li(external_link(text,url)).html_safe
  end

end
