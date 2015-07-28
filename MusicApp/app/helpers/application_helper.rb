module ApplicationHelper

  def heading(header)
    html = "<h1>"
    html += h(header)
    html += "</h1>"

    html.html_safe
  end

  def generate_authenticity_token
    html = "<input type='hidden'"
    html += "name='authenticity_token'"
    html += "value='#{form_authenticity_token}'>"

    html.html_safe
  end

  def logged_in_as
    return nil unless current_user && current_user.email
    html = "You are logged in as: "
    html += "#{current_user.email}"

    html.html_safe
  end

  def delete_button(url)
    html =  "<form action=#{url} method='post'>"
    html += "<input type='hidden' name='_method' value='delete'>"
    html += "#{generate_authenticity_token}"
    html += "<input type='submit' value='delete'></form>"

    html.html_safe
  end

  def edit_button(url)
    html =  "<form action=#{url}>"
    html += "<input type='submit' value='edit'></form>"

    html.html_safe
  end

  def new_button(url)
    html =  "<form action=#{url}>"
    html += "<input type='submit' value='new'></form>"

    html.html_safe
  end

end
# <form action="<%= session_url %>" method="post">
#   <input type="hidden" name="_method" value="delete">
#   <%= generate_authenticity_token %>
#   <input type="submit" value="log out">
# </form>
