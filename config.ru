require_relative './config/environment.rb'
require_all 'app'

if ActiveRecord::Migrator.needs_migration?
  raise "Migrations are pending. Run `rake db:migrate` to resolve the issue."
end

use Rack::MethodOverride
use UsersController
use TasksController
use SubtasksController
run ApplicationController
