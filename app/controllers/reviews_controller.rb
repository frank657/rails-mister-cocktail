class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(user_params)
  end

  private

  def user_params
    params.require(:review).permit(:content, :rating)
  end
end
