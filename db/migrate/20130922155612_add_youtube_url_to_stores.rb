class AddYoutubeUrlToStores < ActiveRecord::Migration
  def change
    add_column :stores, :youtube_url, :string
  end
end
