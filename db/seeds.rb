# Clear existing data
Comment.destroy_all
Post.destroy_all
User.destroy_all

puts "🏫 Creating Riverside High School Blog..."

# Create users (faculty and students)
principal = User.create!(
  first_name: "Sarah",
  last_name: "Martinez",
  email: "smartinez@riversidehigh.edu"
)

coach = User.create!(
  first_name: "Mike",
  last_name: "Thompson",
  email: "mthompson@riversidehigh.edu"
)

drama_teacher = User.create!(
  first_name: "Emily",
  last_name: "Chen",
  email: "echen@riversidehigh.edu"
)

student_council = User.create!(
  first_name: "Jordan",
  last_name: "Williams",
  email: "jwilliams@student.riversidehigh.edu"
)

yearbook_editor = User.create!(
  first_name: "Alex",
  last_name: "Rodriguez",
  email: "arodriguez@student.riversidehigh.edu"
)

puts "✅ Created #{User.count} users"

# Published Posts
homecoming_post = Post.create!(
  title: "Homecoming Dance 2025: A Night Under the Stars",
  body: "Get ready for the most magical night of the year! This year's homecoming dance theme is 'Starlight Serenade' and will take place on November 15th in the gymnasium from 7-11 PM.

Tickets are on sale now for $25 per person or $45 per couple. Purchase your tickets at the student council office during lunch or after school.

Dress code: Semi-formal attire. The gym will be transformed into a celestial wonderland with twinkling lights, a professional DJ, and a photo booth with props!

Don't forget to vote for Homecoming King and Queen - voting closes November 10th. Let's make this a night to remember!",
  author: student_council,
  published_at: 2.days.ago
)

basketball_post = Post.create!(
  title: "Riverside Wildcats Heading to State Championships!",
  body: "What an incredible season! After last Friday's nail-biting 78-76 victory against Lincoln High, our Varsity Basketball team has secured their spot in the State Championships!

The championship game will be held on November 20th at 6 PM at the State Arena. This is the first time in 15 years that Riverside has made it to State!

Senior captain Marcus Johnson led the team with 28 points, while sophomore sensation Maya Patel contributed 22 points and 8 assists. Coach Thompson said, 'This team has shown incredible heart and determination all season. We're not done yet!'

Bus transportation will be provided for students - sign up in the athletics office. Let's pack the arena and show our Wildcat pride! GO WILDCATS! 🏀",
  author: coach,
  published_at: 5.days.ago
)

spring_play_post = Post.create!(
  title: "Auditions Open for Spring Musical: The Wizard of Oz",
  body: "Follow the yellow brick road to the auditorium! Riverside Drama Department is thrilled to announce that our spring musical will be The Wizard of Oz!

AUDITION DETAILS:
📅 When: November 18-19, 3:30-6:00 PM
📍 Where: Main Auditorium
🎭 Who: All students welcome! No experience necessary.

We're looking for Dorothy, the Scarecrow, the Tin Man, the Cowardly Lion, and many more roles including ensemble members and technical crew.

Please prepare a 1-minute monologue and 16 bars of a song of your choice. Bring your enthusiasm and your best ruby slippers attitude!

Callbacks will be held November 20th. Show dates are March 15-17, 2026.

Questions? Email Ms. Chen at echen@riversidehigh.edu or stop by room 204.

Break a leg! 🌈",
  author: drama_teacher,
  published_at: 1.week.ago
)

graduation_post = Post.create!(
  title: "Senior Spotlight: Graduation Ceremony Details Announced",
  body: "Congratulations to the Class of 2026! We are so proud of you and can't wait to celebrate your achievements.

GRADUATION CEREMONY
Date: June 5, 2026
Time: 6:00 PM
Location: Riverside Stadium (Rain location: Main Gymnasium)

IMPORTANT DATES:
- Cap & Gown Orders Due: January 15, 2026
- Senior Photos Due: February 1, 2026
- Graduation Practice: June 4, 2026 at 2 PM

Each graduate will receive 6 guest tickets. Additional tickets may be available in May depending on capacity.

This year's commencement speaker will be alumna Dr. Jennifer Park, Chief of Surgery at City General Hospital and Riverside Class of 2001.

Senior families - mark your calendars for the Senior Awards Night on May 20th and the Senior Breakfast on June 5th at 8 AM.

The countdown begins! We can't wait to see you walk across that stage. 🎓",
  author: principal,
  published_at: 3.days.ago
)

# Draft/Unpublished Posts
soccer_draft = Post.create!(
  title: "Girls Soccer Team Prepares for Regional Tournament",
  body: "Our Lady Wildcats soccer team has been training hard for the upcoming regional tournament. After an impressive 12-3 season, they're ready to take on the competition.

The tournament starts November 22nd. More details coming soon about scheduling and ticket information.

Coach Martinez says the team's defense has been outstanding this year, with goalkeeper Sofia Chen recording 8 shutouts. Seniors Emma Davis and Riley Martinez have been leading scorers.

Stay tuned for the official announcement!",
  author: coach,
  published_at: nil
)

talent_show_draft = Post.create!(
  title: "Winter Talent Show - Save the Date!",
  body: "The annual Riverside Winter Talent Show is coming in December! We're still finalizing the date and details, but wanted to give you all a heads up.

This is your chance to showcase your singing, dancing, comedy, magic, or any other talent you want to share with the school.

Auditions will be held in early December. More information coming next week!

Get your acts ready! 🌟",
  author: student_council,
  published_at: nil
)

puts "✅ Created #{Post.count} posts (#{Post.where.not(published_at: nil).count} published, #{Post.where(published_at: nil).count} drafts)"

# Comments
homecoming_post.comments.create!([
  {
    body: "Can't wait! Already got my dress! 💃",
    author: yearbook_editor
  },
  {
    body: "The student council has done an amazing job organizing this. So excited to see the gym transformation!",
    author: drama_teacher
  },
  {
    body: "This is going to be epic! Who's going with me??",
    author: student_council
  }
])

basketball_post.comments.create!([
  {
    body: "SO PROUD of our team! I'll definitely be on that bus to State!",
    author: student_council
  },
  {
    body: "Incredible game on Friday! The energy in that gym was electric. Let's go Wildcats!",
    author: principal
  },
  {
    body: "This team has worked so hard. They deserve this! 🏀🔥",
    author: drama_teacher
  },
  {
    body: "Already planning the pep rally! This is HUGE for our school!",
    author: yearbook_editor
  }
])

spring_play_post.comments.create!([
  {
    body: "I've always wanted to be Dorothy! See everyone at auditions!",
    author: yearbook_editor
  },
  {
    body: "Even if you're nervous about auditioning, just go for it! Drama club is like a family. You'll love it!",
    author: student_council
  }
])

graduation_post.comments.create!([
  {
    body: "I can't believe graduation is already being planned. Senior year is flying by! 😭",
    author: yearbook_editor
  },
  {
    body: "This is going to be such an emotional day. So proud of our seniors already!",
    author: drama_teacher
  }
])

puts "✅ Created #{Comment.count} comments"

puts "\n🎉 Seed data complete!"
puts "   #{User.count} users"
puts "   #{Post.count} posts (#{Post.where.not(published_at: nil).count} published)"
puts "   #{Comment.count} comments"
puts "\n📧 Try logging in with:"
puts "   - smartinez@riversidehigh.edu (Principal Martinez)"
puts "   - mthompson@riversidehigh.edu (Coach Thompson)"
puts "   - jwilliams@student.riversidehigh.edu (Student Council)"
