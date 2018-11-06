require 'nokogiri'
require 'open-uri'
require 'json'
require "csv"

origin = "http://fallout.wikia.com/"
ammo_link = "wiki/Fallout:_New_Vegas_ammunition"
ammo_url = "#{origin}#{ammo_link}"

doc = Nokogiri::HTML(open(ammo_url))

tables = []
categories = []
links = []
names = []
weights = []
prices = []
descriptions = []
images = []

tables = doc.css('table.va-table')

# guns
ammo = tables[0].css("tr")
ammo_count = ammo.size - 1
for i in 1..ammo_count
  if (i == 1 || i == 5 || i == 9 || i == 13 || i == 17 || i == 21 || i == 24 || i == 29 || i == 34 || i == 40 || i == 44 || i == 47 || i == 51 || i == 61)
    # puts i
    # puts ammo[i].css("td a")[0]["href"]
    # puts doc.css("span.mw-headline")[1].text
    # puts ammo[i].css("td a")[0].text.chomp()
    # puts ammo[i].css("td")[2].text.chomp().gsub(/\s+/, "")
    # puts ammo[i].css("td")[4].text.chomp().gsub(/\s+/, "")
    # puts

    links.push(ammo[i].css("td a")[0]["href"])
    categories.push(doc.css("span.mw-headline")[1].text)
    names.push(ammo[i].css("td a")[0].text.chomp())
    weights.push(ammo[i].css("td")[2].text.chomp())
    prices.push(ammo[i].css("td")[4].text.chomp())
  end
end

# explosives
ammo = tables[1].css("tr")
ammo_count = ammo.size - 1
for i in 1..ammo_count
  if (i == 1 || i == 6 || i == 10 || i == 14 || i == 19)

    links.push(ammo[i].css("td a")[0]["href"])
    categories.push(doc.css("span.mw-headline")[2].text)
    names.push(ammo[i].css("td a")[0].text.chomp())
    weights.push(ammo[i].css("td")[2].text.chomp())
    prices.push(ammo[i].css("td")[4].text.chomp())
  end
end

# energy
ammo = tables[2].css("tr")
ammo_count = ammo.size - 1
for i in 1..ammo_count
  if (i == 1 || i == 3 || i == 8 || i == 13 || i == 16 || i == 21)

    links.push(ammo[i].css("td a")[0]["href"])
    categories.push(doc.css("span.mw-headline")[3].text)
    names.push(ammo[i].css("td a")[0].text.chomp())
    weights.push(ammo[i].css("td")[2].text.chomp())
    prices.push(ammo[i].css("td")[4].text.chomp())
  end
end

CSV.open("ammo.csv", "wb") do |csv|
  csv << ["id", "category", "name", "weight", "price", "description"]
  for i in 0..links.length - 1

    single_ammo_url = "#{origin}#{links[i]}"
    ammo_doc = Nokogiri::HTML(open(single_ammo_url))

    description = ammo_doc.css('span#Characteristics').first.parent.next_element.text.chomp()
    box = ammo_doc.css('a.image-thumbnail')[0].attr('href')
    round = ammo_doc.css('a.image-thumbnail')[1].attr('href')
    image_name = ammo_doc.css('h2.pi-title').text

    File.open("images/ammo/rounds/#{image_name}_round.png", 'wb') do |fo|
      fo.write open("#{round}").read
    end
    File.open("images/ammo/boxes/#{image_name}_box.png", 'wb') do |fo|
      fo.write open("#{box}").read
    end
    puts "#{image_name} scraped successfully... "

    descriptions.push(description)
    id = "#{i+1}"
    csv << [id, categories[i], names[i], weights[i], prices[i], descriptions[i]]
  end
end


puts "Process ran successfully :)"