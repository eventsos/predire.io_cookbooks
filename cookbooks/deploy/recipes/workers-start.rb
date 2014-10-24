include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  ruby_block "start all predire.io background workers #{application}" do
    block do
      Chef::Log.info("starting all processes: #{node[:deploy][application][:nodejs][:restart_command]}")
      fork { exec 'php workers/fetch_tweets.php' }
      ignore_failure true
    end
  end

end
