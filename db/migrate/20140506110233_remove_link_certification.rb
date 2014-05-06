class RemoveLinkCertification < ActiveRecord::Migration
  def change
    remove_column :user_certifications, :link, :string
  end
end
