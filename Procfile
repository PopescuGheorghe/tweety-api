web: export RAILS_ENV=${RAILS_ENV:=production}; bundle exec puma -e $RAILS_ENV -p $PORT -C config/puma.rb config.ru
worker:  export RAILS_ENV=${RAILS_ENV:=production}; bundle exec sidekiq -C config/sidekiq.yml
