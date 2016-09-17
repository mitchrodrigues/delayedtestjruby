# Very simple - keep in models for auto reload and no need to require
# since this is prototype

# 1 second is about average request time, between negotiating SSL
# as well as the rest of the cycle.
class NormalJob
  def perform
    sleep(1)
    Rails.logger.info 'Normal Job Running'
  end
end