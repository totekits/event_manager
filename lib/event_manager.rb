require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'
require 'date'

def find_register_day(time_string)
  time = Time.strptime(time_string, "%m/%d/%Y %k:%M").wday
end

def find_register_hour(time_string)
  time = Time.strptime(time_string, "%m/%d/%Y %k:%M").hour
end

def clean_phone_numbers(phone_numbers)
  phone_numbers.to_s.delete("^0-9")
  if phone_numbers.size == 11 && phone_numbers[0] == "1"
    phone_numbers[1..-1]
  else
    phone_numbers = "Invalid Phone Numbers"
  end
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

hours = []
days = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_numbers = clean_phone_numbers(row[:homephone])

  register_hour = find_register_hour(row[:regdate])
  hours << register_hour

  register_day = find_register_day(row[:regdate])
  days << register_day 

  legislators = legislators_by_zipcode(zipcode)
  form_letter = erb_template.result(binding)
  save_thank_you_letter(id,form_letter)
end

pop_hour = hours.tally.max_by { |k, v| v }.first
pop_day = Date::DAYNAMES[days.tally.max_by { |k, v| v }.first]

puts "The most popular register hour is #{pop_hour}\n" +
  "The most popular register day of the week is #{pop_day}"