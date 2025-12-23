# Seed tortillas
%w[flour gluten\ free].each do |name|
	Tortilla.find_or_create_by!(name: name)
end

# Seed sizes
%w[medium large extra\ large].each do |name|
	Size.find_or_create_by!(name: name)
end

# Seed fillings
%w[beans rice steak chicken shrimp fish pork tofu cheese].each do |name|
	Filling.find_or_create_by!(name: name)
end

# Seed toppings
%w[cheese guacamole sour\ cream lettuce onion tomato cilantro chile\ verde salsa\ picante].each do |name|
	Topping.find_or_create_by!(name: name)
end

# Create an admin user if none exists
admin_email = ENV.fetch("ADMIN_EMAIL", "admin@example.com")
admin_password = ENV.fetch("ADMIN_PASSWORD", "password")
User.find_or_create_by!(email: admin_email) do |u|
	u.first_name = "Admin"
	u.last_name = "User"
	u.password = admin_password
	u.is_admin = 1
end

