class CreateClusterJob 
    def perform(name)
        batch = Sidekiq::Batch.new
        batch.description = "Batch description (this is optional)"
        batch.on(:success, CreateClusterJob::Created, :to => 'my@gmail.com')
        batch.jobs do
            5.times { |i| SendMailJob.perform_async(i,to) }
        end
        puts "Just started Batch #{batch.bid}"
    end

    class Created
        def on_success(status,options)
            puts "----"
            puts status,options
            puts "cluster created"
            # status = Sidekiq::Batch::Status.new(status.bid)
           puts status.total # jobs in the batch => 98
           puts status.failures # failed jobs so far => 5
           puts status.pending # jobs which have not succeeded yet => 17
           puts status.created_at # => 2012-09-04 21:15:05 -0700
           puts status.complete? # if all jobs have executed at least once => false
            # puts status.join # blocks until the batch is considered complete, note that some jobs might have failed
           puts status.failure_info # an array of failed jobs
           puts status.data # a hash of data about the batch which can easily be converted to JSON for javascript usage
        end
        def on_complete(status, options)
            puts "Uh oh, batch has failures" if status.failures != 0
        end
    end
end