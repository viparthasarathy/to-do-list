require_relative './config/environment.rb'

APP_ROOT = File.dirname(__FILE__)
set :public_folder, File.join(APP_ROOT, "public")
if ActiveRecord::Migrator.needs_migration?
  raise "Migrations are pending. Run `rake db:migrate` to resolve the issue."
end

use Rack::MethodOverride
use UsersController
use TasksController
use SubtasksController
run ApplicationController
