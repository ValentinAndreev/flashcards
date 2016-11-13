# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'rubygems'
require 'open-uri'
require 'nokogiri'

url = 'http://www.languagedaily.com/learn-german/vocabulary/common-german-words'
html = open(url)
page = Nokogiri::HTML(html)
index = 0
page.css('.rowA', '.rowB').each do |data|
  parse = data.text.to_s.split("\r\n")
  Card.create(original_text: parse[2], translated_text: parse[3], review_date: 3.days.from_now.to_date)
  index += 1
end
puts "Загружено #{index} слов"
