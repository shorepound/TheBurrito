namespace :dev do
  desc "Stop Spring, clear tmp caches and restart Rails server in background (127.0.0.1:3000)"
  task :restart_server do
    app_root = File.expand_path('../../', __dir__)
    Dir.chdir(app_root) do
      puts "Stopping spring (if running)..."
      system('bin/spring stop')

      server_pid_file = File.join('tmp', 'pids', 'server.pid')
      if File.exist?(server_pid_file)
        pid = File.read(server_pid_file).to_i
        begin
          puts "Killing server pid #{pid}..."
          Process.kill('TERM', pid)
          sleep 1
        rescue Errno::ESRCH
          puts "No process #{pid}"
        end
        File.delete(server_pid_file) rescue nil
      end

      puts "Removing tmp caches..."
      system('rm -rf tmp/cache tmp/bootsnap*')

      puts "Starting rails server in background (127.0.0.1:3000)..."
      FileUtils.mkdir_p('log') unless Dir.exist?('log')
      log_file = File.open('log/dev_server_task.log', 'a')
      pid = spawn('bin/rails', 'server', '-b', '127.0.0.1', '-p', '3000', out: log_file, err: log_file, chdir: app_root)
      Process.detach(pid)
      puts "Started server (pid=#{pid}). Logs: log/dev_server_task.log"
    end
  end
end
