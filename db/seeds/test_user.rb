admin = User.create({
          name: "admin",
          email: "admin@example.com",
          password: "password",
          password_confirmation: "password",
          role: "admin",
          gender: "male",
          birth: "1995-09-11",
          dietary_reference_intake_id: 1
        })

general = User.create({
            name: "general",
            email: "general@example.com",
            password: "password",
            password_confirmation: "password",
            role: "general",
            gender: "female",
            birth: "2001-12-03",
            dietary_reference_intake_id: 1
            })

users = [admin, general]
users.each do |u|
  u.save!
end