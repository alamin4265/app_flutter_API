import 'dart:io';
import 'package:StudentInformation/Model/ClientModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:math' as math;

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  
  static Database _database;

  Future<Database> get database async {
    
    if (_database != null)
    return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  initDB() async {
    join(await getDatabasesPath(), 'app_flutterDB.db');
    onCreate: (db, version) {
      return db.execute("CREATE TABLE Client ("
          "id INTEGER PRIMARY KEY,"
          "first_name TEXT,"
          "last_name TEXT,"
          "blocked BIT"
          ")");
    };
    version: 1;
  }

  // initDB() async {
  //   //Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(await getDatabasesPath(), 'doggie_database.db');
  //   return await openDatabase(path, version: 1, onOpen: (db) {
  //   }, onCreate: (Database db, int version) async {
  //     await db.execute("CREATE TABLE Client ("
  //         "id INTEGER PRIMARY KEY,"
  //         "first_name TEXT,"
  //         "last_name TEXT,"
  //         "blocked BIT"
  //         ")");
  //   });
  // }

  newClient(Client newClient) async {
    final db = await database;
    var res = await db.insert("Client", newClient.toJson());
    return res;
  }

  getAllClients() async {
    final db = await database;
    var res = await db.query("Client");
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromJson(c)).toList() : [];
    return list;
  }

  getClient(int id) async {
    final db = await database;
    var res =await  db.query("Client", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Client.fromJson(res.first) : Null ;
  }

  getBlockedClients() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    List<Client> list =
        res.isNotEmpty ? res.toList().map((c) => Client.fromJson(c)) : null;
    return list;
  }

  updateClient(Client newClient) async {
    final db = await database;
    var res = await db.update("Client", newClient.toJson(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  deleteClient(int id) async {
    final db = await database;
    db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

  
deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }

}


class ClientData extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ClientData();
  }
}

class _ClientData extends State<ClientData>{
  // List<Client> testClients = [
  //   Client(id:1,firstName: "Raouf", lastName: "Rahiche", blocked: false),
  //   Client(id:2,firstName: "Zaki", lastName: "oun", blocked: true),
  //   Client(id:3,firstName: "oussama", lastName: "ali", blocked: false),
  // ];

  
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(title: Text("Flutter SQLite")),
      body: FutureBuilder<List<Client>>(
        future: DBProvider.db.getAllClients(),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Client item = snapshot.data[index];
                return ListTile(
                  title: Text(item.lastName),
                  leading: Text(item.id.toString()),
                  trailing: Checkbox(
                    onChanged: (bool value) {
                      //DBProvider.db.blockClient(item);
                      setState(() {});
                    },
                    value: item.blocked,
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          //Client rnd = testClients[math.Random().nextInt(testClients.length)];
          //await DBProvider.db.newClient(rnd);
          setState(() {});
        },
      ),
    );
  }
}