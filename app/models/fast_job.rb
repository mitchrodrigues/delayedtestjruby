# Very simple - keep in models for auto reload and no need to require
# since this is prototype

# BOOM its done
class FastJob
  def perform
    Rails.logger.info 'Fast Job Running'
  end
end