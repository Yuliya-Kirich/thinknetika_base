class Admin::AnswersController < Admin::BaseController
  before_action :find_question, only: %i[new create]
  before_action :set_answer, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_answer_not_found

  def show; end

  def new
    @answer = @question.answers.new
  end

  def edit; end

  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to @answer, notice: 'Ответ на вопрос удачно создан'
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to @answer.question
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def rescue_with_answer_not_found
    render plain: 'Такого ответа на вопрос не занесли в списки'
  end

  def users_spoof_check
    if user_signed_in?
      redirect_to root_url if current_user.id != @answer.question.test.user_id
    else
      redirect_to user_confirmation_url
    end
  end
end
