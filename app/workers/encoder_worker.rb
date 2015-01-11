class EncoderWorker
  include Sidekiq::Worker

  def perform(_media, count)
    media = Media.new(_media["bucket"],
                      _media["file_name"], _media["size"])
    media.inspect
  end
end