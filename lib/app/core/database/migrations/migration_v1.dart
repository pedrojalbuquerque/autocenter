import 'package:autocenter/app/core/database/migrations/migration.dart';
import 'package:sqflite_common/sqlite_api.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table order(
        id Integer primary key autoincrement,
        client_id Integer,
        created_at datetime,
        amount double,
        discount double,
        payment_type char(30),
        installments Integer,
        foreign key (client_id) references client(id)
      );
    ''');

    batch.execute('''
      create table orderproducts(
        id Integer primary key autoincrement,
        order_id Integer,
        product_id Integer,
        created_at datetime,
        description varchar(50),
        quantity Integer,
        cost_price double,
        sell_price double,
        tax double,
        foreign key (order_id) references order(id),
        foreign key (product_id) references product(id)
      )
    ''');

    batch.execute('''
      create table client(
        id Integer primary key autoincrement,
        name varchar(100) not null,
        cell_phone varchar(11) not null,
        vehicle varchar(30),
        plate varchar(7),
        km Integer,
        created_at datetime,
      );
    ''');

    batch.execute('''
      create table product(
        id Integer primary key autoincrement,
        description varchar(50) not null,
        suppliers varchar(100) not null,
        cost_price double,
        delivery_tax double,
        created_at datetime,
      )
    ''');
  }

  @override
  void update(Batch batch) {}
}
