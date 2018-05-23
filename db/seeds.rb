# Seed subjects
10.times do
  Subject.create(name: Faker::ProgrammingLanguage.name)
end

# Subject.create(name: 'Scratch')
# Subject.create(name: 'Python')
# Subject.create(name: 'Ruby on Rails')
# Subject.create(name: 'PHP')
# Subject.create(name: 'Mobile App Development')
# Subject.create(name: 'Responsive Website Design')

# Seed students and volunteers
address = ""
50.times do
  address = Address.new(venue_name: '',
                         address_formatted: '',
                         address_1: Faker::Address.street_address,
                         address_2: Faker::Address.secondary_address,
                         city: Faker::Address.city,
                         state: Faker::Address.state,
                         postal_code: Faker::Address.zip_code,
                         address_type: rand(0..2)) # enumerator uses this
  address.save

  Student.create(first_name: Faker::Name.first_name,
                 last_name: Faker::Name.last_name,
                 email: Faker::Internet.email,
                 phone: Faker::PhoneNumber.phone_number,
                 birth_date: Faker::Date.between(15.year.ago, 8.year.ago),
                 gender: rand(0..1),
                 address: address)

  # address2 = Address.create(venue_name: '',
  #                          address_formatted: '',
  #                          address_1: Faker::Address.street_address,
  #                          address_2: Faker::Address.secondary_address,
  #                          city: Faker::Address.city,
  #                          state: Faker::Address.state,
  #                          postal_code: Faker::Address.zip_code,
  #                          address_type: rand(0..2))

  # User.create(first_name: Faker::Name.first_name,
  #             last_name: Faker::Name.last_name,
  #             email: Faker::Internet.email,
  #             username: "#{Faker::Name.first_name}#{rand(0..3)}"
  #             phone: Faker::PhoneNumber.phone_number,
  #             address: address2,
  #             role: 1)
end

# create admin
# address2 = Address.create(venue_name: '',
#                          address_formatted: '',
#                          address_1: Faker::Address.street_address,
#                          address_2: Faker::Address.secondary_address,
#                          city: Faker::Address.city,
#                          state: Faker::Address.state,
#                          postal_code: Faker::Address.zip_code,
#                          address_type: rand(0..2))

# User.create(first_name: Faker::Name.first_name,
#                last_name: Faker::Name.last_name,
#                email: Faker::Internet.email,
#                phone: Faker::PhoneNumber.phone_number,
#                birth_date: Faker::Date.between(15.year.ago, 8.year.ago),
#                gender: rand(0..1),
#                address: address2,
#                role: 0)

