# encoding: UTF-8
class Translator < ActiveRecord::Base

  def self.get_translator_by_id (id)
    @translator = Translator.find(id)
  end


  def self.signup!(account, password, name, category)
      Translator.create! do |t|
        t.account = account
        t.password = Digest::MD5.hexdigest(password)
        t.name = name
        t.category = category
    end
  end


end
