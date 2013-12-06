class AdminUser < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :lockable, :timeoutable,
    :recoverable, :rememberable, :trackable, :validatable
end
