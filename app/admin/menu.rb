ActiveAdmin.register Menu do

  permit_params :key, :label, :link

  form do |f|
    f.inputs "Menu detail" do
      f.input :key, :as => :select, :collection => [:about, :privacy, :termofuse], :include_blank => false
      f.input :label
      f.input :link, :input_html => { :placeholder => "/path" }
    end
    f.actions
  end



end
