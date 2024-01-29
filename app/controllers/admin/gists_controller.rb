# frozen_string_literal: true

class Admin::GistsController < Admin::BaseController
  def index
    @gist = Gist.all
  end
end
