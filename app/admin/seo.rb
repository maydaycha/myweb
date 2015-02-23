ActiveAdmin.register Seo, :as => "Customize SEO" do

  permit_params :key, :content, :page

  index do
    column :page
    column :key
    column :content
    actions
  end

  form do |f|
    f.inputs "SEO tag" do
      f.input :page, :as => :select, :collection => [:home, "user category",
       "project category", "howitwork", "howitworkP2", "howitworkP3", "howitworkP3_f", "howitworkP3 other", "howitworkP5", "howitworkP5_j", "howitworkP5_other", "about", "rule", "byot", "group", "groupIns", "partners", "solutions", "SandBYOT", "tool_page"], :include_blank => false
      f.input :key, :as => :select, :collection => [:title, :description, :keywords, :author], :include_blank => false
      f.input :content
    end
    f.actions
  end


end
