class CocktailsController < ApplicationController
  before_action :find_cocktail, only: [:show]
  before_action :user_params, only: [:create]

  def index
    @cocktails = Cocktail.all
  end

  def show
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(user_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'new'
    end
  end

  # def edit
  # end

  # def update
  #   @cocktail.update(user_params)
  #   if @cocktail.save
  #     redirect_to cocktail_path(@cocktail)
  #   else
  #     render 'edit'
  #   end
  # end

  # def destroy
  #   @cocktail.destroy
  # end

  private

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def user_params
    params.require(:cocktail).permit(:name)
  end
end
