ActiveAdmin.register SearchManagement do


  permit_params :category, :allow_internal, :allow_external

  form do |f|
    f.inputs "Detail" do
      f.input :category, :as => :select, :collection => [:freelancer, :job], :include_blank => false
      f.input :allow_internal
      f.input :allow_external
    end
    f.actions
  end



end
