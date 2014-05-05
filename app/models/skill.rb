require 'spreadsheet'

class Skill < ActiveRecord::Base
  def self.import_from_csv
    book = Spreadsheet.open "#{Rails.root}/db/20140428_skill.xls"
    sheet1 = book.worksheet 0
    sheet1.each_with_index do |row, index|
      next if index < 2
      Skill.create!(name: row[0])
    end
  end
end
