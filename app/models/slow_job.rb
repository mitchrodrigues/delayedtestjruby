# Very simple - keep in models for auto reload and no need to require
# since this is prototype

# Slow job sleep for 10seconds, mimicing wether or not a
# webrequest is being slow.
class SlowJob
  def perform
    sleep(10)
    Rails.logger.info 'Finally Running'
  end
end