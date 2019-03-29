class ReviewsController < ApplicationController
  before_action :find_cocktail, only: [:new, :create]
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(user_params)
    @review.cocktail = @cocktail
    if @review.save
      redirect_to cocktail_path(@cocktail)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def user_params
    params.require(:review).permit(:content, :rating)
  end
end
