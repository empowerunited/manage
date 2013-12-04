# desc "Explaining what the task does"
# task :manage do
#   # Task goes here
# end

namespace :manage do
  desc "Create the initial admin user for the interface"
  task :create_admin => :environment do
    user = Manage::AdminUser.create!(
      :email => "admin@admin.com", 
      :password => "11223344", 
      :password_confirmation => "11223344"
    )
  end
end
