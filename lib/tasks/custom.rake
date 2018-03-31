namespace :tweety do
  desc 'Create twitter search job'
  task create_twitter_search_job: :environment do
    job = Sidekiq::Cron::Job.find('search_twitter_job')

    unless job
      job = Sidekiq::Cron::Job.new(
        name: 'search_twitter_job',
        cron: '0 * * * *',
        class: 'Workers::TwitterSearchWorker'
      )
      puts job.errors unless job.save
    end
  end
end
