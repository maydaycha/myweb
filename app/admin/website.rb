ActiveAdmin.register Website do

  permit_params :logo, :swiper, :it_software, :science_engineer, :creativity_design, :sales, :service, :business, :writness, :consulting



  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Detail" do
      f.input :logo, :as => :file
      f.input :swiper, :as => :file
      f.input :it_software, :as => :file
      f.input :science_engineer, :as => :file
      f.input :creativity_design, :as => :file
      f.input :sales, :as => :file
      f.input :service, :as => :file
      f.input :business, :as => :file
      f.input :writness, :as => :file
      f.input :consulting, :as => :file
    end
    f.actions
  end

  show do |website|
    attributes_table do
      row :logo do
        image_tag url_for(:controller => "/application", :action => "show_image", :model => website.class.name, :attribute => :logo, :id => website.id), class: "img-thumbnail img-responsive", width: "113", height: "113"
      end

      row :swiper do
        image_tag url_for(:controller => "/application", :action => "show_image", :model => website.class.name, :attribute => :swiper, :id => website.id), class: "img-thumbnail img-responsive", width: "113", height: "113"
      end

      row :it_software do
        image_tag url_for(:controller => "/application", :action => "show_image", :model => website.class.name, :attribute => :it_software, :id => website.id), class: "img-thumbnail img-responsive", width: "113", height: "113"
      end

      row :science_engineer do
        image_tag url_for(:controller => "/application", :action => "show_image", :model => website.class.name, :attribute => :science_engineer, :id => website.id), class: "img-thumbnail img-responsive", width: "113", height: "113"
      end

      row :creativity_design do
        image_tag url_for(:controller => "/application", :action => "show_image", :model => website.class.name, :attribute => :creativity_design, :id => website.id), class: "img-thumbnail img-responsive", width: "113", height: "113"
      end

      row :sales do
        image_tag url_for(:controller => "/application", :action => "show_image", :model => website.class.name, :attribute => :sales, :id => website.id), class: "img-thumbnail img-responsive", width: "113", height: "113"
      end

      row :service do
        image_tag url_for(:controller => "/application", :action => "show_image", :model => website.class.name, :attribute => :service, :id => website.id), class: "img-thumbnail img-responsive", width: "113", height: "113"
      end

      row :business do
        image_tag url_for(:controller => "/application", :action => "show_image", :model => website.class.name, :attribute => :business, :id => website.id), class: "img-thumbnail img-responsive", width: "113", height: "113"
      end

      row :writness do
        image_tag url_for(:controller => "/application", :action => "show_image", :model => website.class.name, :attribute => :writness, :id => website.id), class: "img-thumbnail img-responsive", width: "113", height: "113"
      end

      row :consulting do
        image_tag url_for(:controller => "/application", :action => "show_image", :model => website.class.name, :attribute => :consulting, :id => website.id), class: "img-thumbnail img-responsive", width: "113", height: "113"
      end

    end

  end



  controller do

    def index
      return redirect_to action: "show", id: Website.first.id
    end

    def create
      params[:website].each do |key, value|
        params[:website][key] = open(params[:website][key].tempfile).read if not params[:website][key].nil?
      end
      super
    end

    def update
      params[:website].each do |key, value|
        params[:website][key] = open(params[:website][key].tempfile).read if not params[:website][key].nil?
      end
      super
    end

  end


end
