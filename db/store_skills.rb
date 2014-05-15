require 'mysql2'
require 'spreadsheet'

#my = Mysql.new(hostname, username, password, databasename)
client = Mysql2::Client.new(
    :host => 'telework.c3hdqvev57qg.ap-northeast-1.rds.amazonaws.com',
    :username => 'sun',
    :password => 'suntelework',
    :port => '5566',
    :database => 'sun',
    :socket => '/private/var/mysql/mysql.sock',
    :encoding => 'utf8',
    :sslca => '../config/amazon-rds-ca-cert.pem'
    )

puts client.inspect
results = client.query("SELECT * FROM user_skills WHERE group='githubbers'")
puts "test"
while client.next_result
  result = client.store_result
  puts result
  # result now contains the next result set
end

# book = Spreadsheet.open "#{Rails.root}/db/20140428_skill.xls"
# sheet1 = book.worksheet 0
# sheet1.each_with_index do |row, index|
#       next if index < 2
#       Skill.create!(name: row[0])
#     end

# rs = con.query('select * from student')
# rs.each_hash { |h| puts h['name']}
client.close

