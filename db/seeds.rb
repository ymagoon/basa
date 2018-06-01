puts 'destroying previous seeds...'
Course.destroy_all
Proficiency.destroy_all
Subject.destroy_all
Student.destroy_all
Address.destroy_all
User.destroy_all
VolunteerRoster.destroy_all
StudentRoster.destroy_all
Attendance.destroy_all

# generate email for student/volunteer
def generate_email(first_name, last_name)
  "#{first_name}.#{last_name}@gmail.com"
end

def randomize_gender
  # if random number is > .3, return male, else return female
  rand(100) / 100.0 > 0.3 ? 0 : 1
end

def course_name(subject)
  "#{subject.name} Basics #{rand(1000...9999)}"
end

def rand_attendance
  rand(100) / 100.0 > 0.65 ? 0 : 1
end



# Seed subjects
puts 'creating subjects...'
Subject.create(name: 'Scratch')
Subject.create(name: 'Python')
Subject.create(name: 'Robotics')

# Seed addresses for locations
puts 'creating addresses...'
address1 = Address.create(venue_name: 'Henderson',
                      address_formatted: '',
                      address_1: Faker::Address.street_address,
                      address_2: Faker::Address.secondary_address,
                      city: Faker::Address.city,
                      state: Faker::Address.state,
                      postal_code: Faker::Address.zip_code,
                      address_type: 0) # venue

address2 = Address.create(venue_name: 'Bedok',
                      address_formatted: '',
                      address_1: Faker::Address.street_address,
                      address_2: Faker::Address.secondary_address,
                      city: Faker::Address.city,
                      state: Faker::Address.state,
                      postal_code: Faker::Address.zip_code,
                      address_type: 0) # venue

address3 = Address.create(venue_name: 'Woodlands',
                      address_formatted: '',
                      address_1: Faker::Address.street_address,
                      address_2: Faker::Address.secondary_address,
                      city: Faker::Address.city,
                      state: Faker::Address.state,
                      postal_code: Faker::Address.zip_code,
                      address_type: 0) # venue

address4 = Address.create(venue_name: 'Tiong Bahru',
                      address_formatted: '',
                      address_1: Faker::Address.street_address,
                      address_2: Faker::Address.secondary_address,
                      city: Faker::Address.city,
                      state: Faker::Address.state,
                      postal_code: Faker::Address.zip_code,
                      address_type: 0) # venue

venues = [address1, address2, address3, address4]

# Seed addresses for students
s_address = Address.create(venue_name: '',
                      address_formatted: '',
                      address_1: Faker::Address.street_address,
                      address_2: Faker::Address.secondary_address,
                      city: Faker::Address.city,
                      state: Faker::Address.state,
                      postal_code: Faker::Address.zip_code,
                      address_type: 2) # students
# create address for volunteers
v_address = Address.create(venue_name: '',
                      address_formatted: '',
                      address_1: Faker::Address.street_address,
                      address_2: Faker::Address.secondary_address,
                      city: Faker::Address.city,
                      state: Faker::Address.state,
                      postal_code: Faker::Address.zip_code,
                      address_type: 1) # volunteers

# Create students from 8 - 11
puts 'creating students...'
240.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  Student.create(first_name: first_name,
                 last_name: last_name,
                 email: generate_email(first_name, last_name),
                 phone: Faker::PhoneNumber.phone_number,
                 birth_date: Faker::Date.between(11.year.ago, 8.year.ago),
                 gender: randomize_gender,
                 address: s_address)
end
# Create students from 12 - 15
160.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  Student.create(first_name: first_name,
                 last_name: last_name,
                 email: generate_email(first_name, last_name),
                 phone: Faker::PhoneNumber.phone_number,
                 birth_date: Faker::Date.between(15.year.ago, 12.year.ago),
                 gender: randomize_gender,
                 address: s_address)
end

# Seed users
puts 'creating volunteers...'
scratch = Subject.find_by_name('Scratch')
python = Subject.find_by_name('Python')
robotics = Subject.find_by_name('Robotics')

# Create Admin
first_name = Faker::Name.first_name
last_name =  Faker::Name.last_name

User.create(first_name: first_name,
            last_name: last_name,
            email: generate_email(first_name, last_name),
            username: "#{Faker::Name.first_name}#{rand(0..3)}",
            password: '12345678',
            phone: Faker::PhoneNumber.phone_number,
            role: 0)

# Create users with Scratch proficiency
25.times do
  first_name = Faker::Name.first_name
  last_name =  Faker::Name.last_name

  user = User.create(first_name: first_name,
                     last_name: last_name,
                     email: generate_email(first_name, last_name),
                     username: "#{Faker::Name.first_name}#{rand(10000..99999)}",
                     password: '12345678',
                     phone: Faker::PhoneNumber.phone_number,
                     role: 1)

  puts user.errors.full_messages if user.errors
  # everyone has assistant role
  Proficiency.create(user: user, subject: scratch, role: 1)
  # 50% of volunteers are teachers
  if rand(0..2) > 0
    Proficiency.create(user: user, subject: scratch, role: 0)
  end
end

# Create users with Python proficiency
12.times do
  first_name = Faker::Name.first_name
  last_name =  Faker::Name.last_name

  user = User.create!(first_name: first_name,
                     last_name: last_name,
                     email: generate_email(first_name, last_name),
                     username: "#{Faker::Name.first_name}#{rand(10000..99999)}",
                     password: '12345678',
                     phone: Faker::PhoneNumber.phone_number,
                     role: 1)
  puts user.errors.full_messages if user.errors
  # everyone has assistant role
  Proficiency.create(user: user, subject: python, role: 1)
  # 50% of volunteers are teachers
  if rand(0..2) > 0
    Proficiency.create!(user: user, subject: python, role: 0)
  end
end

# Create users with Robotics proficiency
3.times do
  first_name = Faker::Name.first_name
  last_name =  Faker::Name.last_name

  user = User.create!(first_name: first_name,
                     last_name: last_name,
                     email: generate_email(first_name, last_name),
                     username: "#{Faker::Name.first_name}#{rand(10000..99999)}",
                     password: '12345678',
                     phone: Faker::PhoneNumber.phone_number,
                     role: 1)

  puts user.errors.full_messages if user.errors

  # everyone has assistant role
  Proficiency.create!(user: user, subject: robotics, role: 1)
  # 50% of volunteers are teachers
  if rand(0..2) > 0
    Proficiency.create!(user: user, subject: robotics, role: 0)
  end
end

# Create courses
puts 'creating courses...'
scratch_teacher = User.joins(:proficiencies).where('users.role = 1 and proficiencies.role = 0 and subject_id = ?', scratch.id).first
scratch_assistant = User.joins(:proficiencies).where('users.role = 1 and proficiencies.role = 1 and subject_id = ?', scratch.id).last

py_teacher = User.joins(:proficiencies).where('users.role = 1 and proficiencies.role = 0 and subject_id = ?', python.id).first
py_assistant = User.joins(:proficiencies).where('users.role = 1 and proficiencies.role = 1 and subject_id = ?', python.id).last

# Create scratch courses
# 10 sessions, weekly
10.times do |n|
  course = Course.create(subject: scratch,
                         start_date: DateTime.now - 100,
                         end_date: DateTime.now - 30,
                         frequency: 1,
                        address: venues.sample,
                         min_capacity: 10,
                         max_capacity: 20,
                         session_length: 60,
                        name: course_name(scratch))
  v1 = VolunteerRoster.create!(course: course, user: scratch_teacher, role: 0)
  v2 = VolunteerRoster.create!(course: course, user: scratch_assistant, role: 1)
end

# Create python courses
# 10 sessions, weekly
5.times do
  course = Course.create(subject: python,
                         start_date: DateTime.now - 100,
                         end_date: DateTime.now - 30,
                         frequency: 1,
                         address: venues.sample,
                         min_capacity: 10,
                         max_capacity: 20,
                         session_length: 60,
                         name: course_name(python))
  v1 = VolunteerRoster.create(course: course, user: py_teacher, role: 0)
  v2 = VolunteerRoster.create(course: course, user: py_assistant, role: 1)
end

# Assign students to courses
puts 'Assigning students to courses...'
courses = Course.all
students = Student.all.map {|s| s.id }

pointer = 0
courses.each do |course|
  (students[pointer]...students[pointer + 20]).each do |student|
    StudentRoster.create!(course: course, student_id: student)
  end
  pointer += 20
end

# Seed attendance to 65% present
puts 'creating attendance...'
attendances = Attendance.all

attendances.each do |attendance|
  attendance.update(present: rand_attendance)
end
