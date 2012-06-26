namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
    
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    
    #Firms
    firm = Firm.new(name: "Firma 1",
                         corporate_id: "2234567-8",
                         location: "Helsinki")
    firm.resource = Bakery.new(description: "Sample description")
    firm.save!
    
    20.times do |n|
      name  = Faker::Company.name
      corporate_id = "1234567-#{n}"
      location = Faker::Address.city
      resource = Bakery.new(description: "Sample description #{n}")
      f = Firm.create!(name: name,
                   corporate_id: corporate_id,
                   location: location,
                   resource: resource)
      #Materials
      material = Material.new(name: "Kala",
                        price: 1.3)
      material.save!
    
      10.times do |n|
        name  = Faker::Name.name
        price = n
        bakery = resource
        Material.create!(name: name,
                     price: price,
                     bakery: bakery)
      end
    
    end
  end
  
  desc "Create admin to database"
  task create_admin: :environment do
    admin = User.create!(name: "admin",
                         email: "example@foo.bar",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
  end  
  
end
