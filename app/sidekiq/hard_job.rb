class HardJob
  include Sidekiq::Job

  def perform()
    name= "222"
   puts "Hard Job perform method is here with name #{name} and count #{name}"
  end
end
