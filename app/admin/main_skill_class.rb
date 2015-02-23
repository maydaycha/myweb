ActiveAdmin.register MainSkillClass do


  permit_params :name, :picture

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Detail" do
      f.input :name
      f.input :picture, :as => :file
    end
    f.actions
  end

  index do
    column :name
    actions
  end

  show do |s|
    attributes_table do
      row :name
      row :picture do
        image_tag url_for(:controller => "/application", :action => "show_image", :model => s.class.name, :attribute => :picture, :id => s.id), class: "img-thumbnail img-responsive", width: "113", height: "113"
      end
    end

  end


  controller do
    def create
      params[:main_skill_class].each do |key, value|
        if value.class != String
          params[:main_skill_class][key] = open(params[:main_skill_class][key].tempfile).read if not params[:main_skill_class][key].nil?
        end
      end

      super
    end

    def update
      params[:main_skill_class].each do |key, value|
        if value.class != String
          params[:main_skill_class][key] = open(params[:main_skill_class][key].tempfile).read if not params[:main_skill_class][key].nil?
        end
      end

      super
    end


  end


end
