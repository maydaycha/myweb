# encoding: UTF-8
require 'csv'
class Project < ActiveRecord::Base
  has_many :project_public_message
  has_many :project_questions
  has_many :messages_of_projects
  has_many :user_appying_projects

  belongs_to :user

  # attr_accessor :translator_name
  attr_accessor :have_public_message

  #class method
  def self.to_csv( options = {} )
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def self.get_total_words(projects)
    sum = 0
    projects.each do |p| sum += p.word_count end
    return sum
  end

  #instance method
  def has_public_mesage?
    ProjectPublicMessage.where(:project_id => self.outside_id).limit(1).size > 0
  end


  def get_public_message
    ProjectPublicMessage.where(:project_id => self.outside_id)
  end

  def has_translated?
    self.is_translation > 0
  end

  def get_translator_name
    Translator.find_by_id(self.translators) ? Translator.find(self.translators).name : "dont have translator"
  end


end
