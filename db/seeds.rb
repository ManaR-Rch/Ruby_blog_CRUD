# Create a default user for development
user = User.find_or_initialize_by(email: "user@example.com")
user.name = "Test User"
# role defaults to "member" in the database
user.save!

puts "✅ Seed data created successfully!"
puts "👤 User created: #{user.email}"