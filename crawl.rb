require 'rubygems'
require 'mechanize'

agent = Mechanize.new
pageCount = (1..2)
searchStrings = ['inurl:"-law.com" -site:law.com', 'inurl:"law.net" -site:law.net',
'inurl:"lawfirm.com" -site:lawfirm.com', 'inurl:"lawfirm.com" inurl:"the" -site:lawfirm.com -inurl:whois -inurl:site -inurl:stats -inurl:company']

page = agent.get('http://www.google.com')
form = page.form('f')
form.q = searchStrings[0].to_s
page = agent.submit(form, form.buttons.first)
page.search('cite').each do |link|
	if link.to_s =~ /legalzoom/
		pp 'advertisement'
	else
		#here we would write to a file instead of printing to console
		pp link.text.to_s
	end
end
pp page.links_with(:text => 'Next')
