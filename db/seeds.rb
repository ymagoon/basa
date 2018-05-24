# Seed subjects
Subject.create(name: 'Scratch')
Subject.create(name: 'Python')
Subject.create(name: 'Ruby on Rails')
Subject.create(name: 'PHP')
Subject.create(name: 'Mobile App Development')
Subject.create(name: 'Responsive Website Design')
Subject.create(name: 'C#')
Subject.create(name: 'Blockchain Technology')

# Seed students and volunteers
address = ""
address2 = ""
50.times do
  address = Address.new(venue_name: '',
                        address_formatted: '',
                        address_1: Faker::Address.street_address,
                        address_2: Faker::Address.secondary_address,
                        city: Faker::Address.city,
                        state: Faker::Address.state,
                        postal_code: Faker::Address.zip_code,
                        address_type: 2) # enumerator uses this
  address.save

  Student.create(first_name: Faker::Name.first_name,
                 last_name: Faker::Name.last_name,
                 email: Faker::Internet.email,
                 phone: Faker::PhoneNumber.phone_number,
                 birth_date: Faker::Date.between(15.year.ago, 8.year.ago),
                 gender: rand(0..1),
                 address: address)

  # address2 = Address.new(venue_name: '',
  #                        address_formatted: '',
  #                        address_1: Faker::Address.street_address,
  #                        address_2: Faker::Address.secondary_address,
  #                        city: Faker::Address.city,
  #                        state: Faker::Address.state,
  #                        postal_code: Faker::Address.zip_code,
  #                        address_type: 1)
  # address2.save
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              username: "#{Faker::Name.first_name}#{rand(0..3)}",
              password: '12345678',
              phone: Faker::PhoneNumber.phone_number,
              # address: address2,
              role: 1)
end

# create admin
address3 = Address.create(venue_name: '',
                         address_formatted: '',
                         address_1: Faker::Address.street_address,
                         address_2: Faker::Address.secondary_address,
                         city: Faker::Address.city,
                         state: Faker::Address.state,
                         postal_code: Faker::Address.zip_code,
                         address_type: 1)

User.create(first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email,
            username: "#{Faker::Name.first_name}#{rand(0..3)}",
            password: '12345678',
            phone: Faker::PhoneNumber.phone_number,
            # address: address2,
            role: 0)


# c1 = Course.create( { subject_id: 1, start_date: DateTime.now, end_date: DateTime.now + 10, frequency: 1, number_of_sessions: 10, address_id: 1, min_capacity: 10, max_capacity: 20, notes: "Some notes about the course here", session_length: 90, status: 0 } )

# c2 = Course.create( { subject_id: 2, start_date: DateTime.now + 10, end_date: DateTime.now + 20, frequency: 1, number_of_sessions: 10, address_id: 1, min_capacity: 10, max_capacity: 20, notes: "Some notes about the course here", session_length: 90, status: 0 } )
