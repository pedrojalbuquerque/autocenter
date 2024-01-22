import 'package:autocenter/app/core/database/migrations/migration.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
// batch.execute('CREATE TABLE os '
//         '(id INTEGER PRIMARY KEY '
//         'AUTOINCREMENT,'
//         ' clientid TEXT,'
//         ' createdat TEXT,'
//         ' amount TEXT,'
//         ' discount TEXT'
//         ')');

// batch.execute('CREATE TABLE CUSTOMER '
//         '(id INTEGER PRIMARY KEY '
//         'AUTOINCREMENT,'
//         ' name TEXT,'
//         ' email TEXT,'
//         ' phone TEXT,'
//         ' city TEXT'
//         ')');

    batch.execute('''CREATE TABLE osorder (
      id Integer primary key autoincrement,
        client_id Integer,
        created_at datetime,
        amount double,
        discount double,
        payment_type char(30),
        installments Integer,
        foreign key (client_id) references client(id)
        )
    ''');

    batch.execute('''
      create table orderproducts (
        id Integer primary key autoincrement,
        order_id Integer,
        product_id Integer,
        created_at datetime,
        description varchar(50),
        quantity Integer,
        cost_price double,
        sell_price double,
        tax double,
        foreign key (order_id) references osorder(id),
        foreign key (product_id) references product(id)
        )
    ''');

    batch.execute('''
      create table client (
        id Integer primary key autoincrement,
        name varchar(100),
        cell_phone varchar(11),
        vehicle varchar(30),
        plate varchar(7),
        km Integer,
        created_at datetime
        )
    ''');

    batch.execute('''
      create table product (
        id Integer primary key autoincrement,
        description varchar(50),
        suppliers varchar(100),
        cost_price double,
        delivery_tax double,
        created_at datetime
      )
    ''');
  }

  @override
  void update(Batch batch) {}
}
