class ThumbnailsWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(thumblist)
    Sidekiq::Queue.new.clear
    GetThumbnails.call(thumblist)
  end
end