
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/provider.dart';

class Dbmanaget{

Database _database;
Future<void> openDb()async{
  _database = await openDatabase(
    // Set the path to the database.
    join(await getDatabasesPath(), 'doggie_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        "CREATE TABLE dog(id INTEGER PRIMARY KEY autoincrement, name TEXT, course TEXT)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,);
}

Future<int> insert(Student st) async{

await openDb();
return await _database.insert('dog', st.toMap());
}

Future<List<Student>> dogs(provider p) async {
  // Get a reference to the database.
  await openDb();

  // Query the table for all The Dogs.
  var foods  = await _database.query('dog');
  List<Student> foodList = List<Student>();

  foods.forEach((currentFood) {
    Student food = Student.fromMapObject(currentFood);

    foodList.add(food);
  });
p.setlist(foodList);
 // return foodList;
  // Convert the List<Map<String, dynamic> into a List<Dog>.
//  return List.generate(maps.length, (i) {
//    return Student(
//      id: maps[i]['id'],
//      name: maps[i]['name'],
//      course: maps[i]['course'],
//    );
//  });
}
Future<int> update(Student st)async{
  await openDb();

  return await _database.update('dog', st.toMap(),where: "id=?",whereArgs: [st.id]);
}
Future<void> deleteDog(int id) async {
  // Get a reference to the database.
  await openDb();

  // Remove the Dog from the Database.
  await _database.delete(
    'dog',
    // Use a `where` clause to delete a specific dog.
    where: "id = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}

}

class Student{

  int id;
  String name;
  String course;
  Student({ this.id,@required this.name,@required this.course});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'course': course,
    };
  }
  Student.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.course = map['course'];

  }
}
