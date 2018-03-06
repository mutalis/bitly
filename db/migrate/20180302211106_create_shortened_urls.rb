class CreateShortenedUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :shortened_urls do |t|
      # the real url that we will redirect to
      t.text :url, null: false

      # the unique key
      t.string :unique_key, null: false

      t.timestamps
    end
    # we will lookup the links in the db by key,
    # also make sure the unique keys are actually unique
    add_index :shortened_urls, :unique_key, unique: true
    add_index :shortened_urls, :url
  end
end
