set :application, "oerfeeds"
set :repository,  "http://oerfeeds.googlecode.com/svn/trunk/"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

ssh_options[:port] = 222

role :app, "oerfeeds.info"
role :web, "oerfeeds.info"
role :db,  "oerfeeds.info", :primary => true


desc "update vendor rails"
task :update_rails do
	for entry in Dir.entries("./vendor/rails")
		if entry[/\REVISION_\d+/]
			repository_revision  = entry.sub("REVISION_","")
		end
	end
	puts repository_revision
	sudo "svn up -r "+  repository_revision +" #{deploy_to}/shared/rails"
end

desc "create symlinks from rails dir into project"
task :create_sym do
	sudo "chown -R mongrel:www  /var/www/oerfeeds"
	sudo "chmod -R 775  /var/www/oerfeeds"
end

desc "tasks to run after checkout"
task :after_update_code do
	create_sym
end
desc "restart"
task :restart do
	sudo "#{deploy_to}/current/script/spin"
end
task :stop do
	sudo "#{deploy_to}/current/script/process/reaper"
end
task :start do
	sudo "#{deploy_to}/current/script/process/spawner"
end
task :tail_log, :roles => :app do
stream "tail -f #{shared_path}/log/production.log"
end
