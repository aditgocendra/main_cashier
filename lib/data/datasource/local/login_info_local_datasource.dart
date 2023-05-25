import 'package:drift/drift.dart';

import 'drift/drift_database.dart';

abstract class LoginInfoDataLocalSource {
  Future create(String uuid);

  Future<String?> get();

  Future delete(String uuid);
}

class LoginInfoLocalDataSourceImpl implements LoginInfoDataLocalSource {
  final DatabaseApp databaseApp;

  LoginInfoLocalDataSourceImpl({
    required this.databaseApp,
  });

  @override
  Future create(String uuid) async {
    await databaseApp.into(databaseApp.loginInfoTable).insert(
          LoginInfoTableCompanion.insert(
            idUser: Value(uuid),
          ),
        );
  }

  @override
  Future delete(String uuid) async {
    // await (databaseApp.delete(databaseApp.loginInfoTable)
    //       ..where((tbl) => tbl.idUser.equals(uuid)))
    //     .go();

    await databaseApp.delete(databaseApp.loginInfoTable).go();
  }

  @override
  Future<String?> get() async {
    final r = await databaseApp
        .select(
          databaseApp.loginInfoTable,
        )
        .getSingleOrNull();
    if (r == null) {
      return null;
    }
    return r.idUser;
  }
}
