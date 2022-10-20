module ApplicationHelper
  def footer_year
    content_tag(:p,  "2021 - #{Time.now.strftime('%Y')}")
  end
  def github_url(author, repo)
    "<p style='text-align: center'><a href='#{author}'>Информация об авторе: Кириченко Юлия. </a><a href='#{repo}'>проект Тест Гуру</a></p>".html_safe
  end
end