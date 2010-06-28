#!/usr/bin/env ruby
Dir.glob('/home/nmakino/.gem/ruby/1.8/gems/**/lib') {|f| $: << f }
require 'cgi'
require 'open-uri'
require 'erubis'
require 'rexml/document'
include REXML

cgi = CGI.new
url = cgi['url'] #takes the URL fromt he atomReader.rb 


file = open(url.strip)
doc = Document.new(file)

feed = {}

doc.elements.each("feed/title"){|element| feed["title"] = element.text }
doc.elements.each("feed/subtitle"){|element| feed["subtitle"] = element.text}
doc.elements.each("feed/link"){|element| feed["link"] = element.attributes["href"]}
doc.elements.each("feed/updated"){|element| feed["updated"] = element.text}
doc.elements.each("feed/author/name"){|element| feed["name"]=element.text}
doc.elements.each("feed/author/email"){|element| feed["email"] = element.text}
doc.elements.each("feed/id"){|element| feed["id"] = element.text}

elements = []
i = 1
XPath.each(doc,'//feed/entry'){|entry|
	elements[i] = {}
	elements[i]["title"] = entry.elements['title'].text
	elements[i]["id"] = entry.elements['id'].text
	elements[i]["link"] = entry.elements['link'].attributes["href"]
	elements[i]["summary"] = entry.elements['summary']
	elements[i]["content"] = entry.elements['content']
	i += 1
}

i = 1
XPath.each(doc,'//feed/entry/author'){|entry|
	elements[i]["author"] = entry.elements['name']
	i += 1}

(1..elements.length-1).each{|j|
	if !elements[j]["author"].nil?
		 elements[j]["author"] = elements[j]["author"].text
	end }

puts "Content-Type: text/html"
puts

eruby = Erubis::Eruby.new(File.read('news.eruby'))
puts eruby.result(binding())  

