// import 'package:sqflite/sqflite.dart';

// final String tableTodo = 'todo';
// final String columnId = '_id';
// final String columnTitle = 'title';
// final String columnDone = 'done';

// class Todo {
//   int id;
//   String title;
//   bool done;

//   Map<String, Object?> toMap() {
//     var map = <String, Object?>{
//       columnTitle: title,
//       columnDone: done == true ? 1 : 0
//     };
//     if (id != null) {
//       map[columnId] = id;
//     }
//     return map;
//   }

//   Todo();

//   Todo.fromMap(Map<String, Object?> map) {
//     id = map[columnId];
//     title = map[columnTitle];
//     done = map[columnDone] == 1;
//   }
// }

// class TodoProvider {
//   Database db;

//   Future open(String path) async {
//     db = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//       await db.execute('''
// create table $tableTodo ( 
//   $columnId integer primary key autoincrement, 
//   $columnTitle text not null,
//   $columnDone integer not null)
// ''');
//     });
//   }

//   Future<Todo> insert(Todo todo) async {
//     todo.id = await db.insert(tableTodo, todo.toMap());
//     return todo;
//   }

//   Future<Todo> getTodo(int id) async {
//     List<Map> maps = await db.query(tableTodo,
//         columns: [columnId, columnDone, columnTitle],
//         where: '$columnId = ?',
//         whereArgs: [id]);
//     if (maps.length > 0) {
//       return Todo.fromMap(maps.first);
//     }
//     return null;
//   }

//   Future<int> delete(int id) async {
//     return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
//   }

//   Future<int> update(Todo todo) async {
//     return await db.update(tableTodo, todo.toMap(),
//         where: '$columnId = ?', whereArgs: [todo.id]);
//   }

//   Future close() async => db.close();
// }
