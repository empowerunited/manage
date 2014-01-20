class Manage::AdminUsersController < Manage::ResourceController
  index_fields :email, :sign_in_count, :current_sign_in_ip, :last_sign_in_ip
  search_fields :email, :sign_in_count, :current_sign_in_ip, :last_sign_in_ip

  def show
    if params[:id] == 'sign_out'
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      redirect_to '/manage/admin_users/sign_in'
      return
    end

    super
  end

  def update
    if params[:admin_user][:password].blank?
      params[:admin_user].delete(:password)
      params[:admin_user].delete(:password_confirmation)
    end

    super
  end

end
