puts "Clearing existing data..."
Message.destroy_all
Room.destroy_all
User.destroy_all

# Create sample users
puts "Creating users..."
users = [
  { email: 'alice@example.com', password: 'password123', password_confirmation: 'password123' },
  { email: 'bob@example.com', password: 'password123', password_confirmation: 'password123' },
  { email: 'charlie@example.com', password: 'password123', password_confirmation: 'password123' },
  { email: 'diana@example.com', password: 'password123', password_confirmation: 'password123' },
  { email: 'evan@example.com', password: 'password123', password_confirmation: 'password123' }
]

created_users = users.map do |user_data|
  User.create!(user_data)
end

puts "Created #{created_users.size} users"

# Create rooms
puts "Creating rooms..."
rooms_data = [
  {
    name: "General Discussion",
    description: "A place to discuss anything related to our project",
    created_at: 2.weeks.ago
  },
  {
    name: "Tech Support",
    description: "Get help with technical issues and troubleshooting",
    created_at: 12.days.ago
  },
  {
    name: "Random",
    description: "Off-topic conversations and casual chat",
    created_at: 10.days.ago
  },
  {
    name: "Design Team",
    description: "For design-related discussions and feedback",
    created_at: 8.days.ago
  },
  {
    name: "Marketing",
    description: "Discuss marketing strategies and campaigns",
    created_at: 6.days.ago
  },
  {
    name: "Development",
    description: "For developers to discuss code and implementation",
    created_at: 5.days.ago
  },
  {
    name: "Introductions",
    description: "Introduce yourself to the community",
    created_at: 3.days.ago
  }
]

created_rooms = rooms_data.map do |room_data|
  Room.create!(room_data)
end

puts "Created #{created_rooms.size} rooms"

# Sample message content for more realistic data
messages_content = [
  # General conversation starters
  "Has anyone had a chance to review the latest updates?",
  "Good morning everyone! How's your day going?",
  "I'm new here. Can someone help me get started?",
  "What's everyone working on this week?",
  "Just wanted to share that we hit our quarterly goals!",
  "Any thoughts on the new feature request?",
  "Is the server down for anyone else right now?",
  "Thanks for all your help yesterday, team!",

  # Tech specific
  "I'm getting an error when I try to compile the latest code.",
  "Has anyone implemented this feature before? Looking for advice.",
  "The new update is working great on my end.",
  "What IDE is everyone using these days?",
  "Can someone review my pull request when they have time?",
  "Found a bug in the login flow - already working on a fix.",

  # Design related
  "Just shared the new mockups in the shared folder.",
  "What do you think about the color palette for the new landing page?",
  "The user testing results came in - lots of good feedback!",
  "Should we stick with the current font or try something new?",
  "I've updated the design system with new components.",

  # Marketing
  "The campaign metrics look promising so far.",
  "We need to prepare content for the product launch next month.",
  "Who's handling the social media posts this week?",
  "The new blog post is live and already getting good traffic.",

  # Random
  "Did anyone watch the game last night?",
  "Any good lunch recommendations nearby?",
  "Happy Friday everyone!",
  "Check out this interesting article I found.",
  "Does anyone have experience with this tool?",
  "Looking for book recommendations!",

  # Longer messages
  "I've been working on optimizing our database queries and found that we can reduce load time by approximately 40% by implementing proper indexing and query caching. I'll be documenting the changes in our wiki later today.",
  "The customer feedback survey revealed some interesting insights about our user interface. The majority of users found the navigation intuitive, but there were common pain points around the checkout process. I think we should prioritize those improvements for the next sprint.",
  "I wanted to share some thoughts on our current project timeline. Given the recent requirements changes, I believe we should consider adjusting our delivery dates. I've prepared a revised schedule that I think is more realistic while still meeting our key objectives.",
  "After conducting a thorough analysis of our competitors, I've identified several opportunities for differentiation. Our strongest advantage appears to be in our customer service approach, while we could improve our feature set in a few key areas. The complete report is available in the shared drive."
]

# Create messages with realistic distribution
puts "Creating messages..."
messages_to_create = []

created_rooms.each_with_index do |room, index|
  # Determine number of messages based on room type
  message_count = case room.name
    when "General Discussion" then 45
    when "Random" then 38
    when "Tech Support" then 25
    when "Development" then 30
    when "Design Team" then 20
    when "Marketing" then 15
    when "Introductions" then 10
    else rand(5..15)
  end

  # Create messages with realistic timestamps
  message_count.times do |i|
    # More recent messages for all rooms, plus some older ones for established rooms
    time_ago = if i < message_count / 3
                 rand(1..24).hours.ago
               elsif i < message_count * 2 / 3
                 rand(1..5).days.ago
               else
                 rand(5..14).days.ago
               end

    # Make sure message time is after room creation
    time_ago = [time_ago, room.created_at + 1.hour].max

    # Random user for each message
    user = created_users.sample

    messages_to_create << {
      content: messages_content.sample,
      room_id: room.id,
      user_id: user.id,
      created_at: time_ago,
      updated_at: time_ago
    }
  end
end

# Create messages in bulk for better performance
Message.create!(messages_to_create)

# Add additional activity data for specific rooms and users
# This will make the charts more interesting

# Alice is very active in General Discussion
general_room = Room.find_by(name: "General Discussion")
alice = User.find_by(email: "alice@example.com")

10.times do |i|
  Message.create!(
    content: "This is an important announcement: #{i+1}. Please read and acknowledge.",
    room_id: general_room.id,
    user_id: alice.id,
    created_at: rand(1..36).hours.ago
  )
end

# Bob is the tech support guru
tech_room = Room.find_by(name: "Tech Support")
bob = User.find_by(email: "bob@example.com")

8.times do |i|
  Message.create!(
    content: "FAQ #{i+1}: Check the documentation at docs.example.com for common troubleshooting steps.",
    room_id: tech_room.id,
    user_id: bob.id,
    created_at: rand(1..48).hours.ago
  )
end

# Charlie loves the Random channel
random_room = Room.find_by(name: "Random")
charlie = User.find_by(email: "charlie@example.com")

12.times do |i|
  Message.create!(
    content: "Random fact #{i+1}: Did you know that honey never spoils? Archaeologists have found pots of honey in ancient Egyptian tombs that are over 3,000 years old and still perfectly good to eat.",
    room_id: random_room.id,
    user_id: charlie.id,
    created_at: rand(1..72).hours.ago
  )
end

# Diana is leading the Design Team
design_room = Room.find_by(name: "Design Team")
diana = User.find_by(email: "diana@example.com")

7.times do |i|
  Message.create!(
    content: "Design update #{i+1}: I've uploaded new mockups for the profile page. Please review and provide feedback by tomorrow.",
    room_id: design_room.id,
    user_id: diana.id,
    created_at: rand(1..60).hours.ago
  )
end

# Add a burst of recent activity in Development room
dev_room = Room.find_by(name: "Development")
5.times do |i|
  user = created_users.sample
  Message.create!(
    content: "Just pushed a fix for ticket ##{rand(100..999)}. Please pull the latest changes and test.",
    room_id: dev_room.id,
    user_id: user.id,
    created_at: rand(1..12).hours.ago
  )
end

# Print summary
total_messages = Message.count
messages_by_room = Room.all.map { |room| [room.name, Message.where(room_id: room.id).count] }.to_h

# Use a safer approach for counting messages by user
messages_by_user = {}
User.all.each do |user|
  messages_by_user[user.email] = Message.where(user_id: user.id).count
end

puts "Created #{total_messages} messages!"
puts "\nMessages by room:"
messages_by_room.each do |room_name, count|
  puts "- #{room_name}: #{count} messages"
end

puts "\nMessages by user:"
messages_by_user.each do |email, count|
  puts "- #{email}: #{count} messages"
end

puts "\nSeed data creation complete!"
