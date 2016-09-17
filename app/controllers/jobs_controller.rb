class JobsController < ApplicationController

  # Normally I dislike this (Well all the time i dislike this)
  # But due to the simplicity of this app and what we are mocking up
  # we should just keep it that way
  JOB_QUEUE = ThreadSafe::Hash.new


  def index
  end

  def reset
    Delayed::Job.delete_all
    return redirect_to action: :index
  end


  # Delayed jobs doesnt like test mode, so this is hard to spec
  # to prove, however the UI should help with a visual representation
  def queue
    # Delayed Jobs Method
    # Delayed::Job.enqueue(
    #    payload_object: job_constant.new, 
    #    queue: params[:queue],
    #    priority: job_priority
    # )

    # Thread Method
    index = JOB_QUEUE.length


    thread = Thread.new { 

      job_constant.new.perform

      JOB_QUEUE.delete index
    }

    JOB_QUEUE[index] = { job: job_constant, started_at: Time.now, thread: thread }

    return redirect_to action: :index
  end


  private 

  def job_constant
    "#{params[:job].camelize}Job".constantize # Gross
  end

  def job_priority
    case params[:queue]
      when 'high'
        0
      when 'medium'
        1
      when 'low'
        2
    end
  end
end