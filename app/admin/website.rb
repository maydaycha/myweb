ActiveAdmin.register Website do

  permit_params :logo, :swiper, :it_software, :science_engineer, :creativity_design, :sales, :service, :business, :writness, :consulting, :footer_about_en, :footer_about_tw, :footer_about_cn, :footer_privacy_en, :footer_privacy_tw, :footer_privacy_cn, :footer_termofuse_en, :footer_termofuse_tw, :footer_termofuse_cn, :footer_contact_en, :footer_contact_tw, :footer_contact_cn



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

      f.input :footer_about_en
      f.input :footer_about_tw
      f.input :footer_about_cn

      f.input :footer_privacy_en
      f.input :footer_privacy_tw
      f.input :footer_privacy_cn

      f.input :footer_termofuse_en
      f.input :footer_termofuse_tw
      f.input :footer_termofuse_cn

      f.input :footer_contact_en
      f.input :footer_contact_tw
      f.input :footer_contact_cn
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

      row :footer_about_en
      row :footer_about_tw
      row :footer_about_cn

      row :footer_privacy_en
      row :footer_privacy_tw
      row :footer_privacy_cn

      row :footer_termofuse_en
      row :footer_termofuse_tw
      row :footer_termofuse_cn

      row :footer_contact_en
      row :footer_contact_tw
      row :footer_contact_cn

    end

  end



  controller do

    def index
      return redirect_to action: "show", id: Website.first.id
    end

    def create
      params[:website].each do |key, value|
        if value.class != String
          params[:website][key] = open(params[:website][key].tempfile).read if not params[:website][key].nil?
        end
      end
      super
    end

    def update
      params[:website].each do |key, value|
        if value.class != String
          params[:website][key] = open(params[:website][key].tempfile).read if not params[:website][key].nil?
        end
      end
      super
    end

  end


end
