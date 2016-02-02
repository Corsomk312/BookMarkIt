class ThumbnailsWorker
  include Sidekiq::Worker

  def perform
    # in the other file: ThumbnailsWorker.perform_async

    # then here: the code that must be executed
    # pass ID, not object itself, in other file
    # good prac: user local vars

    # bundle exec sidekiq in the rails console?
    # sidekiq_options retry: false (here)

    # change pool size in database.yml (config)
    # HERE: sidekiq_options queue: "high"
    #  be sidekiq -q high,5 default
    # in config/desploy.rb, add require 'sidekiq/capistrano' (something) 6:10

    # in routes, see lars's screenshot
  end
end