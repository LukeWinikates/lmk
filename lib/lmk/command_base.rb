module LMK
  class CommandBase
    attr_reader :command, :timestamp
    attr_accessor :html_url
    
    def get_binding
      binding
    end

    def concise_output
      header.result(get_binding) + 
        status_header.result(get_binding) +
        concise_template.result(get_binding)
    end

    def full_output
      header.result(get_binding) +
        status_header.result(get_binding) +
        full_template.result(get_binding)
    end 

    def full_template
      ERB.new %q{
full output:
----------------------------
<%=output%>}
    end

    def header
      ERB.new %q{
%%% LMK Command Result: %%%
> <%= command %>}
    end

    def status_header
      ERB.new ""
    end

    def concise_template
      ERB.new %q{
<% if html_url %>full result @ <%= html_url %><% end %>}
    end
  end
end
