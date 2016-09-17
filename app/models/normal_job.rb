class NormalJob
  def perform
    sleep(1)
    Rails.logger.info 'Normal Job Running'
  end
end