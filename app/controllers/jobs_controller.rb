class JobsController < ApplicationController

  # Normally I dislike this (Well all the time i dislike this)
  # But due to the simplicity of this app and what we are mocking up
  # we should just keep it that way

  # use a hash cuase it plays nicely with the 
  # [index] and delete assignements
  JOB_QUEUE = ThreadSafe::Hash.new


  # Nothing to do here
  def index
  end


  def reset
    JOB_QUEUE.dub.each do |index, job| 
      # Rescue here incase we ended before reset
      job[:thread].kill rescue nil
      JOB_QUEUE.delete index
    end


    redirect_to action: :index
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

    # This is a thread safe job_queue no need to worry about sticking things in here
    # the [] will handle this
    JOB_QUEUE[index] = { job: job_constant, started_at: Time.now, thread: thread }

    return redirect_to action: :index
  end


  private 

  # We need to constantize the job 
  # from here we use this constant, stick Job on the end 
  # for some sanitization however security isnt a big concern
  # here with this prototype.
  def job_constant
    "#{params[:job].camelize}Job".constantize # Gross
  end

  # Its gross, rubocop would kill me for this.
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