require 'nokogiri'
require 'open-uri'
require 'json'
require "csv"

def self.get_ammo_id(name)
  num = 0
  case name.gsub(/\s+/, "")
    when ".22LRround"
      num = 1
    when ".308round"
      num = 2
    when ".357Magnumround"
      num = 3
    when ".44Magnumround"
      num = 4
    when ".45Auto"
      num = 5
    when ".45-70Gov't"
      num = 6
    when ".50MG"
      num = 7
    when "5mmround"
      num = 8
    when "5.56mmround"
      num = 9
    when "9mmround"
      num = 10
    when "10mmround"
      num = 11
    when "12.7mmround"
      num = 12
    when "12gauge"
      num = 13
    when "20gaugeshotgunshell"
      num = 14
    when "25mmgrenade"
      num = 15
    when "40mm grenade"
      num = 16
    when "Missile"
      num = 17
    when "Mini nuke"
      num = 18
    when "Rocket"
      num = 19
    when "Alienpowercell"
      num = 20
    when "ECP"
      num = 21
    when "SEC"
      num = 22
    when "Flamerfuel"
      num = 23
    when "MFC"
      num = 24
    when "Microfusionbreeder"
      num = 24
    end
    return num
end

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
weights = []
categories = []
munitions = []
prices = []
descriptions = []
images = []

tables = doc.css('table.va-table')
for j in 0..6
  weapon = tables[j].css("tr")
  weapon_count = weapon.size - 1
  for i in 1..weapon_count
    links.push(weapon[i].css("td a")[1]["href"][1..-1])
    categories.push(j+1)
    munitions.push(get_ammo_id(weapon[i].css("td")[10].text.chomp()))
    weights.push(weapon[i].css("td")[13].text.chomp())
    prices.push(weapon[i].css("td")[14].text.chomp())
  end
end

# energy heavy weapons
for j in 7..7
  weapon = tables[j].css("tr")
  weapon_count = weapon.size - 1
  for i in 1..weapon_count
    links.push(weapon[i].css("td a")[1]["href"][1..-1])
    categories.push(j+1)
    munitions.push(get_ammo_id(weapon[i].css("td")[10].text.chomp()))
    weights.push(weapon[i].css("td")[13].text.chomp())
    prices.push(weapon[i].css("td")[14].text.chomp())
  end
end

# explosive projectile
for j in 8..8
  weapon = tables[j].css("tr")
  weapon_count = weapon.size - 1
  for i in 1..weapon_count
    links.push(weapon[i].css("td a")[1]["href"][1..-1])
    categories.push(j+1)
    munitions.push("none")
    weights.push(weapon[i].css("td")[12].text.chomp())
    prices.push(weapon[i].css("td")[13].text.chomp())
  end
end

# explosive THROWN
for j in 9..9
  weapon = tables[j].css("tr")
  weapon_count = weapon.size - 1
  for i in 1..weapon_count
    links.push(weapon[i].css("td a")[1]["href"][1..-1])
    categories.push(j+1)
    munitions.push("none")
    weights.push(weapon[i].css("td")[8].text.chomp())
    prices.push(weapon[i].css("td")[9].text.chomp())
  end
end

# explosive placed
for j in 10..10
  weapon = tables[j].css("tr")
  weapon_count = weapon.size - 1
  for i in 1..weapon_count
    links.push(weapon[i].css("td a")[1]["href"][1..-1])
    categories.push(j+1)
    munitions.push("none")
    weights.push(weapon[i].css("td")[6].text.chomp())
    prices.push(weapon[i].css("td")[7].text.chomp())
  end
end

# melee
for j in 11..13
  weapon = tables[j].css("tr")
  weapon_count = weapon.size - 1
  for i in 1..weapon_count
    links.push(weapon[i].css("td a")[1]["href"][1..-1])
    categories.push(j+1)
    munitions.push("none")
    weights.push(weapon[i].css("td")[10].text.chomp())
    prices.push(weapon[i].css("td")[11].text.chomp())
  end
end

CSV.open("guns.csv", "wb") do |csv|
  csv << ["id", "name", "ammo", "category", "weight", "price", "description"]
  for i in 0..links.length - 1

    single_weapon_url = "#{origin}#{links[i]}"
    weapon_doc = Nokogiri::HTML(open(single_weapon_url))

    description = weapon_doc.css('span#Characteristics').first.parent.next_element.text.chomp()
    image = weapon_doc.css('a.image-thumbnail')[1].attr('href')
    image_name = weapon_doc.css('h2.pi-title').text

    weapons.push(image_name)
    # File.open("images/weapons/#{image_name}.png", 'wb') do |fo|
    #   fo.write open("#{image}").read
    # end
    puts "#{image_name} scraped successfully... [Weight: #{weights[i]}, Price: #{prices[i]}]"

    descriptions.push(description)
    csv << [i+1, weapons[i], munitions[i], categories[i], weights[i], prices[i], descriptions[i]]
  end
end


puts "Process ran successfully :)"