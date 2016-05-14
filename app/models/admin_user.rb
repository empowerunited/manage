class AdminUser < ApplicationRecord
  devise :database_authenticatable, :registerable, :lockable, :timeoutable,
    :recoverable, :rememberable, :trackable, :validatable
end
