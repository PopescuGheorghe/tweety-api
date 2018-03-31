web: export RAILS_ENV=${RAILS_ENV:=development}; bundle exec puma -e $RAILS_ENV -p $PORT -C config/puma.rb config.ru
web-worker: export RAILS_ENV=${RAILS_ENV:=development}; bundle exec sidekiq -C config/sidekiq.yml
