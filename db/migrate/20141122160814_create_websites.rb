class CreateWebsites < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default user
    Website.create! if direction == :up
  end

  def change
    create_table :websites do |t|
      t.binary :logo, limit: 2147483647
      t.binary :swiper, limit: 2147483647
      t.binary :it_software, limit: 2147483647
      t.binary :science_engineer, limit: 2147483647
      t.binary :creativity_design, limit: 2147483647
      t.binary :sales, limit: 2147483647
      t.binary :service, limit: 2147483647
      t.binary :business, limit: 2147483647
      t.binary :writness, limit: 2147483647
      t.binary :consulting, limit: 2147483647

      t.timestamps
    end
  end
end
