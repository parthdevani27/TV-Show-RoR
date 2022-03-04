class HardJob
  include Sidekiq::Job

  def perform(name, count)
   puts "Hard Job perform method is here with name #{name} and count #{count}"
  end
end
