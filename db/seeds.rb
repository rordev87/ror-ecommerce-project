require 'csv'

if (!AdminUser.find_by(email: 'admin@example.com'))
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
end

Category.destroy_all
puts "Categories table destroyed..."
Ammunition.destroy_all
puts "Ammunitions table destroyed..."
Weapon.destroy_all
puts "Weapons table destroyed..."

categories = ['Pistol', 'Rifle', 'SMG', 'Shotgun', 'Heavy', 'Energy Pistol', 'Energy Rifle', 'Energy Heavy', 'Explosive Projectile', 'Explosive Thrown', 'Explosive Placed', 'Melee Bladed', 'Melee Blunt', 'Melee Thrown', 'Melee Unarmed']

categories.each do |category, index|
  cat = Category.new
  cat.name = category
  cat.save
  if (cat.save)
    puts "#{cat.name} saved!"
  else
    puts "#{cat.errors.details}"
  end
end

ammo_csv_text = File.read(Rails.root.join("public/Web-scraper", "ammo.csv"))
ammo_csv = CSV.parse(ammo_csv_text, :headers => true)
ammo_csv.each do |row|
  ammo = Ammunition.create(id: row["id"],
                           name: row["name"],
                           price: row["price"],
                           description: row["description"])
  ammo.save

  if (ammo.save)
    puts "#{ammo.name} saved!"
  else
    puts "#{ammo.errors.details}"
  end
end

lastAmmunition = Ammunition.create(id: 26, name:"Melee", description:"Hit em real good...", price: 0.1, created_at: Time.now, updated_at: Time.now)
if (lastAmmunition.save)
  puts "#{lastAmmunition.name} saved!"
else
  puts "#{lastAmmunition.errors.details}"
end

status_new = Status.create(id: 1, name: "new", discount: 0.1)
status_on_sale = Status.create(id: 2, name: "on sale", discount: 0.3)
status_recently_updated = Status.create(id: 3, name: "recently updated", discount: 0.2)

weapon_csv_text = File.read(Rails.root.join('public', 'Web-scraper', 'guns.csv'))
weapon_csv = CSV.parse(weapon_csv_text, :headers => true)
weapon_csv.each do |row|

  weapon = Weapon.new
  weapon.name = row["name"]

  weapon_image_src = Rails.root.join('public', 'Web-scraper', 'images', 'weapons', "#{row["name"]}.png")
  weapon.image = weapon_image_src.open
  if (weapon.image)
    puts "image upload successful!"
  else
    puts "image error..."
  end

  weapon.price = row["price"]
  weapon.category = Category.find(row["category"].to_i)
  weapon.in_stock = true
  weapon.weight = row["weight"]
  weapon.description = row["description"]
  weapon.status = Status.find(1 + rand(3))

  weapon.save
  if (weapon.save)
    puts "#{weapon.name} saved!"
  else
    puts "#{row["name"]} #{weapon.errors.details}"
  end

  ammoWeapon = WeaponAmmunition.new
  if (row["ammo"] == "none" || row["ammo"] == 0)
    ammo_id = 26
  else
    ammo_id = row["ammo"].to_i
  end
  ammoWeapon.ammunition_id = ammo_id
  ammoWeapon.weapon_id = weapon.id
  ammoWeapon.save
  if (ammoWeapon.save)
    puts "ammoWeapon saved!"
  else
    puts "#{ammoWeapon.errors.details}"
  end
end

provinces = [
  {"id" => 1, "name" => "Alberta", "hst" => 0, "pst" => 0, "gst" => 0.05},
  {"id" => 2, "name" => "British Columbia", "hst" => 0, "pst" => 0.07, "gst" => 0.05},
  {"id" => 3, "name" => "Manitoba", "hst" => 0, "pst" => 0.08, "gst" => 0.05},
  {"id" => 4, "name" => "New Brunswick", "hst" => 0.15, "pst" => 0, "gst" => 0},
  {"id" => 5, "name" => "Newfoundland and Labrador", "hst" => 0.15, "pst" => 0, "gst" => 0},
  {"id" => 6, "name" => "Northwest Territories", "hst" => 0, "pst" => 0, "gst" => 0.5},
  {"id" => 7, "name" => "Nova Scoita", "hst" => 0.15, "pst" => 0, "gst" => 0},
  {"id" => 8, "name" => "Nunavut", "hst" => 0, "pst" => 0, "gst" => 0.5},
  {"id" => 9, "name" => "Ontario", "hst" => 0.13, "pst" => 0, "gst" => 0},
  {"id" => 10, "name" => "Prince Edward Island", "hst" => 0.15, "pst" => 0, "gst" => 0},
  {"id" => 11, "name" => "Quebec", "hst" => 0, "pst" => 0.0975, "gst" => 0.05},
  {"id" => 12, "name" => "Saskatchewan", "hst" => 0, "pst" => 0.06, "gst" => 0.05},
  {"id" => 13, "name" => "Yukon", "hst" => 0, "pst" => 0, "gst" => 0.05},
]

provinces.each do |p|
  Province.create(id: p["id"], name: p["name"], hst: p["hst"], pst: p["pst"], gst: p["gst"])
end

puts "Database was seeded successfully..."