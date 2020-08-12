require "active_record"
module ActiveRecord
  class Migration
    def self.check_pending!(connection = Base.connection)
      ActiveRecord::Migrator.migrations_paths = ["#{`bundle show local_bank_gh`}".chop + "/db/migrate"]
      raise ActiveRecord::PendingMigrationError if connection.migration_context.needs_migration?
    end
  end
end

