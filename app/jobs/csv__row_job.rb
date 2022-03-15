class CsvRowJob
    include Sidekiq::Worker
  
    def perform(row)
        p "===="
     p row[1]
     p row
     p "----"
    #   content = Net::HTTP.get(URI(uri))
  
    #   # The only tricky part: we need to store the results
    #   # somewhere so the callback can gather the data together.
    #   # Redis is perfect for this.
    #   # The BID is the Batch ID shared by all jobs in the batch.
    #   Sidekiq.redis do |conn|
    #     conn.hset "crawl-#{self.bid}", name, content.bytesize
    #   end
    end
  end