import 'package:crypto_pulse/application/data/repository/_common/source/local/database/provider/DatabaseProvider.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@module
abstract class DatabaseModule {
  @preResolve
  Future<Database> get database => DatabaseProvider.instance.database;
}