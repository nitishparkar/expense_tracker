FileUtils.mkdir_p('log')
require 'logger'
DB.loggers << Logger.new('log/sequel.log')

RSpec.configure do |c| 
  c.before(:suite) do
    Sequel.extension :migration 
    Sequel::Migrator.run(DB, 'db/migrations') 
    DB[:expenses].truncate
  end

  c.before(:example, :db) do |example|
    DB.log_info("Starting example: #{example.full_description}")
  end

  c.after(:example, :db) do |example|
    DB.log_info("Ending example: #{example.full_description}")
  end

  c.around(:example, :db) do |example| 
    DB.transaction(rollback: :always) { example.run }
  end  
end