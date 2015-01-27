ActiveAdmin.register Seo do


  permit_params :key, :content

  index do
    column :key
    column :content
    actions
  end

  form do |f|
    f.inputs "SEO tag" do
      f.input :key, :as => :select, :collection => [:title, :description, :keywords, :author], :include_blank => false
      f.input :content
    end
    f.actions
  end


end
