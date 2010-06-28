#!/usr/bin/ruby

puts "Content-Type: text/html"
puts
puts "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'>"
puts "<html xmlns='http://www.w3.org/1999/xhtml' lang='en' xml:lang='en'>"

puts "<head>"
puts "<title>Atom 1.0 Feed Viewer</title>"
puts "</head>"

puts "<body>"
puts "<h1>Atom 1.0 Feed Viewer</h1>"
puts "<form name = 'input' action='output.rb' method 'get'>"
puts "<p>URL: <input type='text' name='url' size='60'/></p>"
puts "<p><input type='submit' value='View Feed' /></p>"
puts "</form>"
puts "</body>"
puts "</html>"

