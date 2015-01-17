class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_filter :product_owner?, only: [:edit, :update, :destroy]

  expose(:category)
  expose(:products)
  expose(:product)
  expose(:review) { Review.new }
  expose_decorated(:reviews, ancestor: :product)

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    self.product = Product.new(product_params.merge(user: current_user))

    if product.save
      category.products << product
      redirect_to category_product_url(category, product), notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if self.product.update(product_params)
      redirect_to category_product_url(category, product), notice: 'Product was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /products/1
  def destroy
    if product.destroy
      redirect_to category_url(product.category), notice: 'Product was successfully destroyed.'
    else
      redirect_to category_path, notice: 'Product was not destroyed.'
    end
  end

  private
    def product_params
      params.require(:product).permit(:title, :description, :price, :category_id)
    end

    def product_owner?
      unless current_user == product.user
        flash[:error] = 'You are not allowed to edit this product.'
        redirect_to category_product_url(category, product)
      end
    end
end
