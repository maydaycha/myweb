ActiveAdmin.register Locale do


  permit_params :name, :file_name, :active

  # form :partial => "form"

  form do |f|
    current_path = File.dirname(__FILE__).split("/")[0...-2].join("/")
    @all_files = Dir[current_path + "/config/locales/*"]
    @all_files.map! { |m| m.split("/")[-1] }

    f.inputs "Detail" do
      f.input :name
      f.input :file_name, :as => :select, :collection => @all_files, include_blank: false
      f.input :active
    end

    f.actions
  end




  controller do

    def new
      current_path = File.dirname(__FILE__).split("/")[0...-2].join("/")
      @all_files = Dir[current_path + "/config/locales/*"]
      @all_files.map! { |m| m.split("/")[-1] }
      @locale = Locale.new
    end

  end


end
