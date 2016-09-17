class SlowJob
  def perform
    sleep(10)
    Rails.logger.info 'Finally Running'
  end
end