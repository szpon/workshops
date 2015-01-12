class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]
  
  expose(:categories)
  expose(:category)
  expose(:product) { Product.new }

  def index
  end

  def show
  end

  def new
    if !current_user.admin?
      redirect_to new_user_session_path
    end
  end

  def edit
    if !current_user.admin?
      redirect_to new_user_session_path
    end
  end

  def create
    self.category = Category.new(category_params)

    if !current_user.admin?
      redirect_to new_user_session_path
    else
      if category.save
        redirect_to category, notice: 'Category was successfully created.'
      else
        render action: 'new'
      end
    end
  end

  def update
    if !current_user.admin?
      redirect_to new_user_session_path
    else
      if category.update(category_params)
        redirect_to category, notice: 'Category was successfully updated.'
      else
        render action: 'edit'
      end
    end 
  end

  def destroy
    category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
