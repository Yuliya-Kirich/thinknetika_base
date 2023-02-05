module ApplicationHelper
  def footer_year
    content_tag(:p,  "2021 - #{Time.current.strftime('%Y')}")
  end

  def github_url(author, repo)
    content_tag(:p,  (link_to 'Информация об авторе: Кириченко Юлия. ', author, :target => '_blank') +
      (link_to 'Проект Тест Гуру. ', repo, :target => '_blank'), :style=>'text-align: center')
  end
end
