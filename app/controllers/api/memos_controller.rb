class Api::MemosController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    memo = Memo.new(create_params)
    unless memo.save
      @error_message = [memo.error.full_messages].compact
    end
  end
  
  def index
    @points = Memo.all
  end

  private
  def create_params
    params.permit(:lat, :long)
  end
end
