class Manage::PostsController < Manage::ResourceController
  index_fields :id, 'content', 'user.username', 'user.email'
  edit_fields :content
end
