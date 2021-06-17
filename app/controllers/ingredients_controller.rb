class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update]

  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end

  def show

  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    
  end

  def edit

  end

  def update
    
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
end