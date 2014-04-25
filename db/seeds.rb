User.create(first_name: 'admin', last_name: 'mettleme', email: 'admin@example.com', :password => 'admin987', password_confirmation: 'admin987', admin: true)

# product categories
accessories = Category.create(:name => 'accessories')

SubCategory.create(:name => 'bags', :category => accessories)
SubCategory.create(:name => 'hats', :category => accessories)
SubCategory.create(:name => 'jewelry', :category => accessories)
SubCategory.create(:name => 'scarves', :category => accessories)
SubCategory.create(:name => 'sunglasses', :category => accessories)

dresses = Category.create(:name => 'dresses')

SubCategory.create(:name => 'cocktail', :category => dresses)
SubCategory.create(:name => 'day', :category => dresses)
SubCategory.create(:name => 'evening', :category => dresses)
SubCategory.create(:name => 'maxi', :category => dresses)
SubCategory.create(:name => 'midi', :category => dresses)
SubCategory.create(:name => 'mini', :category => dresses)

intimates = Category.create(:name => 'intimates')

SubCategory.create(:name => 'bras', :category => intimates)
SubCategory.create(:name => 'lingerie sets', :category => intimates)
SubCategory.create(:name => 'sleep wear', :category => intimates)
SubCategory.create(:name => 'underwear', :category => intimates)

jumpsuits = Category.create(:name => 'jumpsuits')

SubCategory.create(:name => 'bodysuits', :category => jumpsuits)
SubCategory.create(:name => 'jumpers', :category => jumpsuits)
SubCategory.create(:name => 'overalls', :category => jumpsuits)
SubCategory.create(:name => 'rompers', :category => jumpsuits)

outerwear = Category.create(:name => 'outerwear')

SubCategory.create(:name => 'blazers', :category => outerwear)
SubCategory.create(:name => 'coats', :category => outerwear)
SubCategory.create(:name => 'jackets', :category => outerwear)
SubCategory.create(:name => 'vest', :category => outerwear)

pants = Category.create(:name => 'pants')

SubCategory.create(:name => 'capris', :category => pants)
SubCategory.create(:name => 'harem', :category => pants)
SubCategory.create(:name => 'jeans', :category => pants)
SubCategory.create(:name => 'leggings', :category => pants)
SubCategory.create(:name => 'trousers', :category => pants)

shorts = Category.create(:name => 'shorts')

SubCategory.create(:name => 'athletic', :category => shorts)
SubCategory.create(:name => 'casual', :category => shorts)
SubCategory.create(:name => 'dress', :category => shorts)
SubCategory.create(:name => 'jeans', :category => shorts)

skirts = Category.create(:name => 'skirts')

SubCategory.create(:name => 'maxi', :category => skirts)
SubCategory.create(:name => 'midi', :category => skirts)
SubCategory.create(:name => 'mini', :category => skirts)
SubCategory.create(:name => 'work', :category => skirts)

swimwear = Category.create(:name => 'swimwear')

SubCategory.create(:name => 'bikini', :category => swimwear)
SubCategory.create(:name => 'full', :category => swimwear)
SubCategory.create(:name => 'shorts', :category => swimwear)

tops = Category.create(:name => 'tops')
SubCategory.create(:name => 'blouses', :category => tops)
SubCategory.create(:name => 'cardigans', :category => tops)
SubCategory.create(:name => 'shirts', :category => tops)
SubCategory.create(:name => 'sweaters', :category => tops)
SubCategory.create(:name => 't-shirts', :category => tops)

#products seasons
Season.create(:name => 'spring')
Season.create(:name => 'summer')
Season.create(:name => 'fall')
Season.create(:name => 'winter')

# products colors
Color.create(:name => 'blue')
Color.create(:name => 'indigo')
Color.create(:name => 'violet')
Color.create(:name => 'red')
Color.create(:name => 'orange')
Color.create(:name => 'yellow')
Color.create(:name => 'light green')
Color.create(:name => 'green')
Color.create(:name => 'emerald')
Color.create(:name => 'white')
Color.create(:name => 'gray')
Color.create(:name => 'titanium')
Color.create(:name => 'black')
Color.create(:name => 'pink')
Color.create(:name => 'brown')
Color.create(:name => 'purple')

# products materials
Material.create(:name => 'cashmere')
Material.create(:name => 'Denim')
Material.create(:name => 'leather')
Material.create(:name => 'metal')
Material.create(:name => 'mixed')
Material.create(:name => 'polyster')
Material.create(:name => 'silk')
Material.create(:name => 'straw')
Material.create(:name => 'suede')
Material.create(:name => 'velvet wool')
Material.create(:name => 'organic')
Material.create(:name => 'fur')
Material.create(:name => 'cotton')
Material.create(:name => 'gold')
Material.create(:name => 'silver')
Material.create(:name => 'platinum')
Material.create(:name => 'plastic')

# product styles
Style.create(:name => 'artistic')
Style.create(:name => 'classic')
Style.create(:name => 'clean')
Style.create(:name => 'corporate')
Style.create(:name => 'cute')
Style.create(:name => 'floral')
Style.create(:name => 'funky')
Style.create(:name => 'high fashion')
Style.create(:name => 'neon')
Style.create(:name => 'preppy')
Style.create(:name => 'sexy')
Style.create(:name => 'sporty')

# Trends
Trend.create(:name => 'blazers')
Trend.create(:name => 'striped dresses')
Trend.create(:name => 'art prints')
Trend.create(:name => 'chunky sweaters')
Trend.create(:name => 'anchor earrings')
Trend.create(:name => 'paint t-shirts')
Trend.create(:name => 'floral')

#Monologue::User.create(name: "admin", email:"admin@example.com", password:"password123", password_confirmation: "password123")
