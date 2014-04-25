desc "activate all stores"
task :activate_all_stores => :environment do
  puts 'activate all stores'

  Store.all.each do |store|
    store.active = true
    store.save
    puts store.active
  end

  puts 'All stores active'
end