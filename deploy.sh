vi lib/manage/version.rb
git commit lib/manage/version.rb -m "version bump"
git push origin master
rm manage*.gem
gem build manage.gemspec
gem push *.gem
