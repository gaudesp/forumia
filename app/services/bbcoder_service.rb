module BbcoderService
    # allowable image formats
    @@imageformats = 'png|bmp|jpg|gif|jpeg'
    @@quote_matcher = '(&quot;|&apos;|)'
  
    # built-in BBCode tabs that will be processed
    @@tags = {
      # tag name => [regex, replace, description, example, enable/disable symbol]
      'Bold' => [
        /\[b(:.*)?\](.*?)\[\/b\1?\]/mi,
        '<strong>\2</strong>', #Proc alternative for example: lambda{ |e| "<strong>#{e[2]}</strong>" }
        'Embolden text',
        'Look [b]here[/b]',
        :bold],
      'Italics' => [
        /\[i(:.+)?\](.*?)\[\/i\1?\]/mi,
        '<em>\2</em>',
        'Italicize or emphasize text',
        'Even my [i]cat[/i] was chasing the mailman!',
        :italics],
      'Underline' => [
        /\[u(:.+)?\](.*?)\[\/u\1?\]/mi,
        '<span style="text-decoration:underline;">\2</span>',
        'Underline',
        'Use it for [u]important[/u] things or something',
        :underline],
      'Strikeout' => [
        /\[s(:.+)?\](.*?)\[\/s\1?\]/mi,
        '<del>\2</del>',
        'Strikeout',
        '[s]nevermind[/s]',
        :strikeout],
      'Link' => [
        /\[url\](.*?)\[\/url\]/mi,
        '<a href="\1" target="_blank">\1</a>',
        'Hyperlink',
        'Maybe try looking on [url]http://google.com[/url]',
        :link],
      'Image' => [
        /\[img(:.+)?\]([^\[\]].*?)\.(#{@@imageformats})\[\/img\1?\]/im,
        '<img src="\2.\3" class="img-fluid" />',
        'Display an image',
        'Check out this crazy cat: [img]http://catsweekly.com/crazycat.jpg[/img]',
        :image],
      'YouTube' => [
        /\[ytb\](.*?)\?v=([\w\d\-]+).*?\[\/ytb\]/im,
        # '<object width="400" height="330"><param name="movie" value="http://www.youtube.com/v/\2"></param><param name="wmode" value="transparent"></param><embed src="http://www.youtube.com/v/\2" type="application/x-shockwave-flash" wmode="transparent" width="400" height="330"></embed></object>',
        '<iframe id="ytplayer" type="text/html" style="width: 100%; height: 300px" src="//youtube.com/embed/\2" frameborder="0"></iframe>',
        'Display a video from YouTube.com',
        '[ytb]http://youtube.com/watch?v=E4Fbk52Mk1w[/ytb]',
        :video],
      'Left' => [
        /\[left(:.+)?\](.*?)\[\/left\1?\]/mi,
        "<div style=\"text-align: left;\">\\2</div>",
        'Aligns contents along the left side',
        '[left]Left-aligned content[/left]',
        :left],
      'Center' => [
        /\[center(:.+)?\](.*?)\[\/center\1?\]/mi,
        "<div style=\"text-align: center;\">\\2</div>",
        'Aligns contents on the center',
        '[center]Centered content[/center]',
        :center],
      'Right' => [
        /\[right(:.+)?\](.*?)\[\/right\1?\]/mi,
        "<div style=\"text-align: right;\">\\2</div>",
        'Aligns contents along the right side',
        '[right]Right-aligned content[/right]',
        :right]
    }
  
    class << self
      # Convert a string with BBCode markup into its corresponding HTML markup
      #
      # === Basic Usage
      #
      # The first parameter is the string off BBCode markup to be processed
      #
      #   text = "[b]some bold text to markup[/b]"
      #   output = BBRuby.to_html(text)
      #   # output => "<strong>some bold text to markup</strong>"
      #
      # === Custom BBCode translations
      #
      # You can supply your own BBCode markup translations to create your own custom markup
      # or override the default BBRuby translations (parameter is a hash of custom translations).
      #
      # The hash takes the following format: "name" => [regexp, replacement, description, example, enable_symbol]
      #
      #  custom_blockquote = {
      #    'Quote' => [
      #      /\[quote(:.*)?=(.*?)\](.*?)\[\/quote\1?\]/mi,
      #      '<div class="quote"><p><cite>\2</cite></p><blockquote>\3</blockquote></div>',
      #      'Quote with citation',
      #      '[quote=mike]please quote me[/quote]',
      #      :quote
      #    ]
      #  }
      #
      # === Enable and Disable specific tags
      #
      # BBRuby will allow you to only enable certain BBCode tags, or to explicitly disable certain tags.
      # Pass in either :disable or :enable to set your method, followed by the comma-separated list of tags
      # you wish to disable or enable
      #
      #   BBRuby.to_html(text, {}, true, :enable, :image, :bold, :quote)
      #   BBRuby.to_html(text, {}, true, :disable, :image, :video, :color)
      #
      def to_html(text, tags_alternative_definition={}, escape_html=true, method=:disable, *tags)
        text = process_tags(text, tags_alternative_definition, escape_html, method, *tags)
  
        # parse spacing
        text.gsub!( /\r\n?/, "\n" )
  
        # return markup
        text
      end
  
      # The same as BBRuby.to_html except the output is passed through simple_format first
      #
      # Returns text transformed into HTML using simple formatting rules. Two or more consecutive newlines(\n\n)
      # are considered as a paragraph and wrapped in <p> tags. One newline (\n) is considered as a linebreak and
      # a <br /> tag is appended. This method does not remove the newlines from the text.
      #
      def to_html_with_formatting(text, tags_alternative_definition={}, escape_html=true, method=:disable, *tags)
        text = process_tags(text, tags_alternative_definition, escape_html, method, *tags)
  
        # parse spacing
        simple_format( text )
      end
  
      # Returns the list of tags processed by BBRuby in a Hash object
      def tag_list
        @@tags
      end
  
      # Checks if text contains any bb tag
      def any_bb_tags?(text)
        tag_list.map{|k,v| v[0]}.any?{|regex| text.match(regex) }
      end
  
      private
  
      def process_tags(text, tags_alternative_definition={}, escape_html=true, method=:disable, *tags)
        text = text.dup
  
        # escape "<, >, &" and quotes to remove any html
        if escape_html
          text.gsub!( '&', '&amp;' )
          text.gsub!( '<', '&lt;' )
          text.gsub!( '>', '&gt;' )
          text.gsub!( '"', '&quot;' )
          text.gsub!( "'", '&apos;' )
        end
  
        tags_definition = @@tags.merge(tags_alternative_definition)
  
        # parse bbcode tags
        case method
        when :enable
          tags_definition.each_value do |t|
            gsub!(text, t[0], t[1]) if tags.include?( t[4] )
          end
        when :disable
          # this works nicely because the default is disable and the default set of tags is [] (so none disabled) :)
          tags_definition.each_value do |t|
            gsub!(text, t[0], t[1]) unless tags.include?( t[4] )
          end
        end
  
        text
      end
  
      def gsub!(text, pattern, replacement)
        if replacement.class == String
          # just replace if replacement is String
          while text.gsub!( pattern, replacement ); end
        else
          # call replacement
          # It may be Proc or lambda with one argument
          # Argument is MatchData. See 'Bold' tag name for example.
          while text.gsub!( pattern ){ replacement.call($~) }; end
        end
      end
  
      # extracted from Rails ActionPack
      def simple_format( text )
        start_tag = '<p>'
        text = text.to_s.dup
        text.gsub!(/\r\n?/, "\n")                     # \r\n and \r => \n
        text.gsub!(/\n\n+/, "</p>\n\n#{start_tag}")  # 2+ newline  => paragraph
        text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />')  # 1 newline   => br
        text.insert 0, start_tag
        text << '</p>'
      end
    end # class << self
  
  end
  
  class String
    # Convert a string with BBCode markup into its corresponding HTML markup
    #
    # === Basic Usage
    #
    #   text = "[b]some bold text to markup[/b]"
    #   output = text.bbcode_to_html
    #   # output => "<strong>some bold text to markup</strong>"
    #
    # === Custom BBCode translations
    #
    # You can supply your own BBCode markup translations to create your own custom markup
    # or override the default BBRuby translations (parameter is a hash of custom translations).
    #
    # The hash takes the following format: "name" => [regexp, replacement, description, example, enable_symbol]
    #
    #  custom_blockquote = {
    #    'Quote' => [
    #      /\[quote(:.*)?=(.*?)\](.*?)\[\/quote\1?\]/mi,
    #      '<div class="quote"><p><cite>\2</cite></p><blockquote>\3</blockquote></div>',
    #      'Quote with citation',
    #      '[quote=mike]please quote me[/quote]',
    #      :quote
    #    ]
    #  }
    #
    #  output = text.bbcode_to_html(custom_blockquote)
    #
    # === Enable and Disable specific tags
    #
    # BBRuby will allow you to only enable certain BBCode tags, or to explicitly disable certain tags.
    # Pass in either :disable or :enable to set your method, followed by the comma-separated list of tags
    # you wish to disable or enable
    #
    #   output = text.bbcode_to_html({}, true, :enable, :image, :bold, :quote)
    #   output = text.bbcode_to_html({}, true, :disable, :image, :video, :color)
    #
    # === HTML auto-escaping
    #
    # By default, BBRuby will auto-escape HTML.  You can prevent this by passing in false as the second
    # parameter
    #
    #   output = text.bbcode_to_html({}, false)
    #
    def bbcode_to_html(tags_alternative_definition = {}, escape_html=true, method=:disable, *tags)
      BbcoderService.to_html(self, tags_alternative_definition, escape_html, method, *tags)
    end
  
    # Replace the string contents with the HTML-converted markup
    def bbcode_to_html!(tags_alternative_definition = {}, escape_html=true, method=:disable, *tags)
      self.replace(BbcoderService.to_html(self, tags_alternative_definition, escape_html, method, *tags))
    end
  
    def bbcode_to_html_with_formatting(tags_alternative_definition = {}, escape_html=true, method=:disable, *tags)
      BbcoderService.to_html_with_formatting(self, tags_alternative_definition, escape_html, method, *tags)
    end
  
    # Replace the string contents with the HTML-converted markup using simple_format
    def bbcode_to_html_with_formatting!(tags_alternative_definition = {}, escape_html=true, method=:disable, *tags)
      self.replace(BbcoderService.to_html_with_formatting(self, tags_alternative_definition, escape_html, method, *tags))
    end
  
    def bbcode_formatted?
      BbcoderService.any_bb_tags?(self)
    end
  end
  