require 'nokogiri'
require 'open-uri'
require 'json'
require "csv"

origin = "http://fallout.wikia.com/"
weapons_link = "wiki/Fallout:_New_Vegas_weapons"
weapons_url = "#{origin}#{weapons_link}"

# armor_link = "wiki/Fallout:_New_Vegas_armor_and_clothing"
# armor_uri = origin.concat(armor_link)

doc = Nokogiri::HTML(open(weapons_url))

# database
# table indexes
# guns 0, 1 ,2 ,3
# energy weapons 4, 5, 6
# explosives 7, 8, 9
# melee 10, 11, 12, 13
tables = []
links = []
weapons = []
damages = []
weights = []
munitions = []
prices = []
descriptions = []
images = []

tables = doc.css('table.va-table')
for j in 0..8
  weapon = tables[j].css("tr")
  weapon_count = weapon.size - 1
  for i in 1..weapon_count
    links.push(weapon[i].css("td a")[1]["href"][1..-1])
    damages.push(weapon[i].css("td")[2].text.chomp())
    munitions.push(weapon[i].css("td")[10].text.chomp())
    weights.push(weapon[i].css("td")[13].text.chomp())
    prices.push(weapon[i].css("td")[14].text.chomp())
  end
end

for j in 8..10
  weapon = tables[j].css("tr")
  weapon_count = weapon.size - 1
  for i in 1..weapon_count
    links.push(weapon[i].css("td a")[1]["href"][1..-1])
    damages.push(weapon[i].css("td")[3].text.chomp())
    munitions.push("none")
    weights.push(weapon[i].css("td")[6].text.chomp())
    prices.push(weapon[i].css("td")[7].text.chomp())
  end
end

for j in 10..14
  weapon = tables[j].css("tr")
  weapon_count = weapon.size - 1
  for i in 1..weapon_count
    links.push(weapon[i].css("td a")[1]["href"][1..-1])
    damages.push(weapon[i].css("td")[2].text.chomp())
    munitions.push("none")
    weights.push(weapon[i].css("td")[10].text.chomp())
    prices.push(weapon[i].css("td")[11].text.chomp())
  end
end

CSV.open("guns.csv", "wb") do |csv|
  csv << ["url", "weapon name", "damage", "ammo used", "weight", "price", "description"]
  for i in 0..links.length - 1

    single_weapon_url = "#{origin}#{links[i]}"
    weapon_doc = Nokogiri::HTML(open(single_weapon_url))

    description = weapon_doc.css('span#Characteristics').first.parent.next_element.text.chomp()
    image = weapon_doc.css('a.image-thumbnail')[1].attr('href')
    image_name = weapon_doc.css('h2.pi-title').text

    weapons.push(image_name)
    File.open("images/#{image_name}.png", 'wb') do |fo|
      fo.write open("#{image}").read
    end
    puts "#{image_name} scraped successfully... "

    descriptions.push(description)
    csv << [links[i], weapons[i], damages[i], munitions[i], weights[i], prices[i], descriptions[i]]
  end
end


puts "Process ran successfully :)"