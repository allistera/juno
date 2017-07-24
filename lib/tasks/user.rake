namespace :user do
  desc 'Create a new admin account'
  task :create_admin, %i[email password organisation] => :environment do |_t, args|
    if args.email && args.password && args.organisation
      organisation = Organisation.find_or_create_by(name: args.organisation)
      user = User.create(email: args.email,
                         password: args.password,
                         password_confirmation: args.password,
                         organisation: organisation,
                         admin: true)
      if user.valid?
        puts 'Admin account created.'
      else
        puts "ERROR: #{user.errors.messages}"
      end
    else
      puts 'ERROR: Email, Password and Organisation Required.'
    end
  end
end
