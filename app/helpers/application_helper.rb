module ApplicationHelper

  def external_link(text, url)
    tag.a(text.html_safe, href:url, target: '_blank').html_safe
  end

  def external_image_link(image_filename, url)
    tag.a(href: url, target: '_blank') do
      image_tag(image_filename, alt: 'YouTube')
    end
  end

  def youtube_image_link(url)
    external_image_link('youtube.png', url)
  end

  def li_external_link(text, url)
    tag.li(external_link(text.html_safe, url)).html_safe
  end

  def youtube_icon_image
    image_path('youtube.png')
  end
end
