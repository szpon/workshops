class ReviewsController < ApplicationController

  expose(:review)
  expose(:product)

  def edit
  end

  def create
    self.review = Review.new(review_params.merge(user: current_user))

    if review.save
      product.reviews << review
      flash[:notice] = 'Review was successfully created.'
    else
      flash[:error] = 'Review was not created.'
    end
    redirect_to category_product_url(product.category, product)
  end

  def destroy
    review.destroy
    redirect_to category_product_url(product.category, product), notice: 'Review was successfully destroyed.'
  end

  private
    def review_params
      params.require(:review).permit(:content, :rating)
    end
end
