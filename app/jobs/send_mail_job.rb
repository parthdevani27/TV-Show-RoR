class SendMailJob 
    include Sidekiq::Worker
    
    def perform(id,name)
        i = rand(1..10)
        puts "Creating server #{id} .--#{name}"
        sleep i
        puts "created server #{id} ---#{name}"
    end
end