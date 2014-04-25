class Authenticated::OrdersController < AuthenticatedController
  skip_before_filter :authorize

  def index
    @orders = @user.orders
  end
end
