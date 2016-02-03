class ThumbnailsWorker
  include Sidekiq::Worker
  # sidekiq_options :retry => false

  def perform(thumb_id)
    # Sidekiq::Queue.new.clear
    GetThumbnails.save_snapshot_to_s3(Bookmark.find(thumb_id))
  end
end