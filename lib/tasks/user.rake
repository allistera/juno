namespace :user do
  desc 'Create a new user account'
  task :create, %i[email password] => :environment do |_t, args|
    if args.email && args.password
      user = User.create(email: args.email,
                         password: args.password,
                         password_confirmation: args.password)

      if user.valid?
        puts 'User account created.'
      else
        puts "ERROR: #{user.errors.messages}"
      end
    else
      puts 'ERROR: Email and/or Password Required.'
    end
  end
end
