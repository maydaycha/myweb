class AddFooterToWebsite < ActiveRecord::Migration
  def change
    add_column :websites, :footer_about_en, :text
    add_column :websites, :footer_about_tw, :text
    add_column :websites, :footer_about_cn, :text

    add_column :websites, :footer_privacy_en, :text
    add_column :websites, :footer_privacy_tw, :text
    add_column :websites, :footer_privacy_cn, :text

    add_column :websites, :footer_termofuse_en, :text
    add_column :websites, :footer_termofuse_tw, :text
    add_column :websites, :footer_termofuse_cn, :text

    add_column :websites, :footer_contact_en, :text
    add_column :websites, :footer_contact_tw, :text
    add_column :websites, :footer_contact_cn, :text
  end
end
