# Define FactoryGirl factories here
FactoryGirl.define do
  # Sequences
  sequence(:name)  { |n| "name #{n}" }
  sequence(:email) { |n| "user#{n}@example.com" }

  # Models
  factory :user do
    email       { generate :email }
    password    'passsword'
    first_name  'John'
    last_name   'Smith'
    
    trait :seller do
      paypal_id '123'
    end
  end
    
  factory :product do
    store
    name 'My Product'
    gender 'women'
    description 'My new product'
    price 100
    in_stock true
    number_in_stock 10
    days_to_ship 2
    made_to_order false
  end
  
  factory :store do
    user { create(:user, :seller) }
    name { generate :name }
    owner_name { generate :name }
    country_id { create(:country).id }
    state_id   { create(:state).id }
    city { generate :name }
    description "Description goes here"
  end  
  
  factory :cart do
    user
    
    trait :anonymous do
      user_id nil
    end
  end
  
  factory :cart_item do
    cart
    product
  end  
  
  factory :favourite do
    user
    favoured      { create(:product) }
    favoured_type 'product'
  end
  
  factory :message do
    sender_id { create(:user).id }
    recipients { [create(:user)] }
    subject "Hello world"
    content "Welcome to Mettle Me"
  end  

  factory :category do
    name { generate :name }
  end
  
  factory :country do
    name { generate :name }
  end
  
  factory :state do
    name { generate :name }
    country
  end
  
  factory :order do
    user
    cart
  end  
end