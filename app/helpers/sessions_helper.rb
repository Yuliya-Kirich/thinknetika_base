module SessionsHelper
  def flash_message(alert)
    (content_tag :p, flash[alert], class: 'flash alert') if flash[alert]
  end
end
