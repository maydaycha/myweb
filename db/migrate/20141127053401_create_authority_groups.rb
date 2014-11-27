class CreateAuthorityGroups < ActiveRecord::Migration

  def migrate(direction)
    super
    # Create a default user
    AuthorityGroup.create!(:name => "level1", :admin_management => true, :multi_language_management => true, :banner_management => true, :menu_management => true, :category_management => true, :promotion_page_management => true, :footer_management => true, :module_management => true, :search_management => true, :user_management => true, :group_management => true, :payment_management => true) if direction == :up
  end

  def change
    create_table :authority_groups do |t|
      t.string :name
      t.boolean :admin_management
      t.boolean :multi_language_management
      t.boolean :banner_management
      t.boolean :menu_management
      t.boolean :category_management
      t.boolean :promotion_page_management
      t.boolean :footer_management
      t.boolean :module_management
      t.boolean :search_management
      t.boolean :user_management
      t.boolean :group_management
      t.boolean :payment_management
      t.timestamps
    end
  end
end

