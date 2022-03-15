require 'csv'
# require 'net/http'

class CsvFilesJob
  include Sidekiq::Worker

  # MAP - create a job for each row
  def perform(csv_filename="/media/pcq92/New Volume/ROR-Learning/tv-show/app/jobs/Machin.csv")
    batch = Sidekiq::Batch.new                  
    batch.on(:success, self.class, 'filename' => csv_filename)
    batch.jobs do
      CSV.foreach(csv_filename, :headers => true) do |row|
        CsvRowJob.perform_async(row.fields)
      end
    end
  end

  # REDUCE - do something with all the results
  def on_success(status, options)
    # Sidekiq Pro will call this once all the RowProcessor jobs are done.
    # data, _ = Sidekiq.redis do |conn|
    #   conn.multi do
    #     puts "@@@@"
    #     conn.hgetall "crawl-#{status.bid}"
    #     conn.del "crawl-#{status.bid}"
    #   end
    puts "----success----"
    puts status,options
    # end

    # data.each_pair do |name, size|
    #   puts "#{name} is #{size} bytes"
    # end
  end
end

