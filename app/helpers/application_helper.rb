module ApplicationHelper
  def breadcrumb_trail
    crumbs = []
    crumbs << link_to('Home', root_path)
    
    case [controller.controller_name.to_sym, controller.action_name.to_sym]
    when [:products, :recent]
      crumbs << 'Shop'
    when [:stores, :index]
      crumbs << 'Stores'
    when [:stores, :show]
      crumbs << link_to('Stores', stores_path)
      crumbs << @store.name
    when [:products, :show]
      crumbs << link_to('Stores', stores_path)
      crumbs << link_to(@product.store.name, store_path(@product.store))
      crumbs << @product.name
    end
    
    crumbs.join.html_safe
  end
  
  def options_for_id_select(model_name)
    model_name.to_s.capitalize.constantize.all.map { |object| [object.name, object.id] }
  end
  
  def link_to_product_thumbnail(thumb_url, big_url)
		link_to image_tag(thumb_url), '#', style: 'width: 65px; height: 92px;', 'data-src' => big_url
  end
  
  def link_to_add_favourite(object)
    if signed_in?
      link_to(
        '&nbsp;'.html_safe, 
        create_favourite_for_user_path(favoured_id: object.id, favoured_type: object.class.name.downcase), 
        method: :post, 
        remote: true,
        class: 'btn_addtofav',
        id: "add_favourite_#{object.id}"
      ) + javascript_tag do <<-eos.html_safe
          // hide 'add favourite' button after user favourites this object
          $('#add_favourite_#{object.id}').live('ajax:success', function() {
            $(this).hide();
          });
        eos
      end
    end
  end
  
  def link_to_add_to_cart(product, cart_class = " ")
    link_to 'Add To Cart', add_to_cart_path(product), method: :put, class: cart_class
  end
  
  def link_to_per_page(number)
    klass = 'active' if (number.to_s == params[:per_page] || (params[:per_page].nil? && number == 30))
    link_to number, pagination_params(per_page: number), class: klass
  end
    
  def continue_shopping_path
    session[:last_non_cart_page] || recent_products_path
  end
  
  def link_to_view_all(collection)
    link_to 'View All', pagination_params
  end

  def pagination_params(overrides = {})
    default_pagination_params.merge(overrides)
  end
  
  def default_pagination_params
    {per_page: params[:per_page], page: params[:page], sort_by: params[:sort_by]}
  end
  
  def product_path(product)
    super store_slug: product.store.slug, slug: product.slug, id: product.id
  end
  
  def sell_path
    signed_in? ? register_seller_user_path : sign_in_path(redirect_to: register_seller_user_path)
  end
  
  def sort_url(sort_by)
    url_for(pagination_params(sort_by: sort_by)).html_safe
  end  
  
  def store_path(store, options = {})
    super options.merge(slug: store.slug)
  end
  
  def timestamp
    # content_tag(:p, Time.now.to_s)
  end
  
  def will_paginate(collection)
    # For options, see https://github.com/mislav/will_paginate/wiki/API-documentation    
    return "" if collection.empty?
    html = super(collection, previous_label: '&lt;', 
												  next_label: '&gt;', 
												inner_window: 1, 
												outer_window: 0, 
												 	 container: false)
    
     if html.blank?
       content_tag(:em, '1', class: 'current')
     else
       html
     end
  end

end
