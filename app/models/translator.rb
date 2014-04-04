# encoding: UTF-8
class Translator < ActiveRecord::Base

  def self.get_translator_by_id (id)
    @translator = Translator.find(id)
  end

end
