module UsersHelper
  def user_header(user)
    content_tag(:div, content_tag(:h1, "#{user_fsm(user)} #{user.first_name} #{user.last_name}"),
                class: 'strong')
  end

  private

  def user_fsm(user)
    if user.persisted?
      'Редактировать данные личного кабинета'
    else
      'Новый пользователь'
    end
  end
end
