require 'spec_helper'

module Manage

  describe PostsController do
    render_views
    routes { Manage::Engine.routes }

    before do
      @admin = AdminUser.create!(email: 'admin@some.gf', password: '11223344', password_confirmation: '11223344')
      sign_in @admin

      @user = User.create!(email: 'some@do.cd', username: 'Sandokan')
      @user.posts.create(content: 'Some')
      @user.save!
    end

    it 'Shows only index fields listed' do
      get :index
      body = response.body

      body.should include(@user.email)
      body.should include(@user.username)
      body.should include(@user.posts.first.id.to_s)
      body.should include(@user.posts.first.content)
    end
  end
end

