module ApplicationHelper

  def show_current_user
    if logged_in?
      "<p> you are logged in as: #{h(current_user.username)}</p>
       <form action=\"#{session_url}\" method=\"post\">
          #{form_auth}
          <input type=\"hidden\" name=\"_method\" value=\"delete\">
          <button>Sign Out</button>
       </form>".html_safe
     else
       "<form action=\"#{new_session_url}\" method=\"get\">
          <button>Sign In</button>
       </form>".html_safe
    end
  end


  def form_auth
    "<input type=\"hidden\"
            name=\"authenticity_token\"
            value=\"#{form_authenticity_token}\">".html_safe
  end

  def show_flash
    if flash[:errors]
      html = "<ul>"
      flash[:errors].each do |error|
        html += "<li>#{error}</li>"
      end
      html += "</ul>"
      html.html_safe
    end
  end

end
