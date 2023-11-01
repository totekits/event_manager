# event_manager
[This project](https://www.theodinproject.com/lessons/ruby-event-manager) is from the Odin Project's curriculum. 
Imagine that a friend of yours runs a non-profit organization around political activism. A number of people have registered for an upcoming event. She has asked for your help in engaging these future attendees. 
## Tasks
1. Find the government representatives for each attendee based on their zip code.
2. Form personalized call to action letters for each attendee.
3. Clean up the phone numbers making sure they are valid and well-formed.
4. Find out which hours of the day the most people registered.
5. Find out which days of the week the most people registered.
## Steps
1. Load csv data file.
2. Clean up the data using Ruby's CSV.
3. Access, clean up, and display names and zipcodes of each attendee.
4. Use Google Civic Info API to access civic data to find the representatives. 
5. Form call to action letters using ERB class.
6. Output the letters to files.
7. Clean phone numbers.
8. Find popular hours and days.
## Things I learned
- Ruby filepathing convention: .rb file in lib folder, reference files in the root
- File class: #read #exist? #readlines
- next if
- require
- CSV class: #open
- String class: #rjust #ljust #slice %{} #gsub #gsub!
- Nil class: #to_s
- Google Civic Information webservice
- How to read URL
- Exception class: begin rescue
- ERB class: <%= %> <% %> 
- Binding class: #binding
- Kernel#puts
- IO#puts
- Date and Time class: #strptime #strftime #hour #wday