# encodnig: utf-8
# Title: Simple Image tag for Jekyll
# Authors: Brandon Mathis http://brandonmathis.com
#          Felix Schäfer, Frederic Hemberger
# Description: Easily output images with optional class names, width, height, title and alt attributes
#
# Syntax {% img [class name(s)] [http[s]:/]/path/to/image [width [height]] [title text | "title text" ["alt text"]] %}
#
# Examples:
# {% img /images/ninja.png Ninja Attack! %}
# {% img left half http://site.com/images/ninja.png Ninja Attack! %}
# {% img left half http://site.com/images/ninja.png 150 150 "Ninja Attack!" "Ninja in attack posture" %}
#
# Output:
# <img src="/images/ninja.png">
# <img class="left half" src="http://site.com/images/ninja.png" title="Ninja Attack!" alt="Ninja Attack!">
# <img class="left half" src="http://site.com/images/ninja.png" width="150" height="150" title="Ninja Attack!" alt="Ninja in attack posture">
#

module Jekyll

  class LinkTag < Liquid::Tag
    @link = nil

    def initialize(tag_name, markup, tokens)
      @link = {}
      link = markup.scan(/([^\s]*?)\s(.*)/i)

      @link[:path] = link[0][0]
      @link[:text] = link[0][1].strip

      super
    end

    def render(context)
      page_url = context.environments.first["page"]["url"]
      klass = ''
      if page_url.index(@link[:path]) == 0
        klass = 'class="current"'
      end
      '<a href="' + @link[:path] + '" ' + klass + '>' + @link[:text] + '</a>'
    end
  end
end

Liquid::Template.register_tag('link', Jekyll::LinkTag)
