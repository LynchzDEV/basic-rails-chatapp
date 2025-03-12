namespace :server do
  desc "Start the Rails server with a custom host (usage: rake server:start HOST=0.0.0.0)"
  task :start do
    host = ENV['HOST'] || 'localhost'
    port = ENV['PORT'] || '3000'

    puts "Starting server on #{host}:#{port}..."
    system("bin/rails server -b #{host} -p #{port}")
  end
end
