import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class Migration {
void create(Batch batch){}
void update(Batch batch){}
}