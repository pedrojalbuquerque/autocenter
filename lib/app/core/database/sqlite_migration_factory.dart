import 'package:autocenter/app/core/database/migrations/migration.dart';
import 'package:autocenter/app/core/database/migrations/migration_v1.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [
        MigrationV1(),
      ];
  List<Migration> getUpdateMigration(int version) {
    // final migrations = <Migration>[];
    // if (version == 1) {
    //   migrations.add(MigrationV2());
    // }
    return <Migration>[];
  }
}
