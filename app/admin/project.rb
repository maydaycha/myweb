ActiveAdmin.register Project do

  permit_params :name, :name_chinese, :require_skills_chinese, :url, :require_skills, :from_source, :description, :description_chinese, :currency, :currency_code, :currency_exchangerate, :public_message, :word_count, :is_emergency, :required_user_level, :work_type, :satisfication, :worked_hours, :worker_location, :english_level, :required_user_intro, :payment_type, :main_skill, :sub_skill, :during_time, :public_message_chinese, :translators


  form :html => { :enctype => "multipart/form-data" } do |f|

    f.inputs "Name" do
      f.input :name
      f.input :name_chinese
    end

    f.inputs "Require Skills" do
      f.input :require_skills
      f.input :require_skills_chinese
    end

    f.inputs "Description" do
      f.input :description
      f.input :description_chinese
    end

    f.inputs "Public Message"  do
      f.input :public_message
      f.input :public_message_chinese
    end

    if not current_admin_user.is_translator and not current_admin_user.is_service
      f.inputs "Other" do
        f.input :budget
        f.input :currency
        f.input :currency_code
        f.input :currency_exchangerate
        f.input :word_count
        f.input :is_emergency
        f.input :required_user_level
        f.input :work_type
        f.input :satisfication
        f.input :worked_hours
        f.input :worker_location
        f.input :english_level
        f.input :required_user_intro
        f.input :payment_type
        f.input :main_skill
        f.input :sub_skill
        f.input :during_time
        f.input :file, as: :file
        f.input :is_translation
        f.input :url
        f.input :from_source
      end
    end
    f.actions
  end


  index do
    column :name
    column :name_chinese
    column "translators" do |t|
       if t.translators != 0 then AdminUser.find(t.translators).username else "NA" end
    end
    actions
  end

  controller do

    def update
      params[:project][:translators] = current_admin_user.id if current_admin_user.is_translator
      super
    end

  end

end
