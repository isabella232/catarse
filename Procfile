web: bundle exec puma -e production -p 5000
worker: bundle exec sidekiq -C config/sidekiq.yml
worker_notifications: bundle exec rake listen:sync_notifications
