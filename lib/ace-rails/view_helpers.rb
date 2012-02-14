module Ace
  module Rails
    module ViewHelpers
      
        def ace_editor(options = {})
          id    = options[:id] || 'editor'
          mode  = options[:mode] || 'css'
          theme = options[:theme] # nil => default theme

          mode_class = "#{mode}_mode".camelize

          theme_setter = theme ? "editor.setTheme('ace/theme/#{theme}');" : ""

          output = <<HTML
<div class='editor_container'>
  <pre id='#{id}'>#{options[:content]}</pre>
  <div class='editor_footer'></div>
</div>
<script type='text/javascript'>
  window.onload = function() {
    window.ace_editors['#{id}'] = ace.edit('#{id}');
    #{theme_setter}
    var #{mode_class} = require("ace/mode/#{mode}").Mode;
    editor.getSession().setMode(new #{mode_class}());
  };
</script>
HTML

          output.html_safe
        end
      
    end
  end
end