import 'package:chat_room_day2/database_helper/message_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';


class DataBaseHelper{

  static const dbname="mydata.db";
  static const dbversion=1;
  static const dbtable="mytable";
  static const dbtablesecond="dbtablesecond";
  static const dbtablethird="dbtablethird";
  static const columnid="id";
  static const columnName="name";

  static final DataBaseHelper instance=DataBaseHelper();//constructor

  static Database? _database;                  //check database is null or not
  Future<Database?> get database async{          // if null then create it
    if(_database !=null){
      return _database;
    }
    _database =await initDataBase();
    return _database;
  }

  initDataBase() async{
    // create database
    io.Directory documentDirectory = await  getApplicationDocumentsDirectory();
    String path=join(documentDirectory.path,dbname);
    var db=await openDatabase(path,version: dbversion,onCreate: _onCreate);
    return db;
  }


  _onCreate(Database db,int version)async{
    await db.execute("CREATE TABLE $dbtable ($columnid INTEGER PRIMARY KEY AUTOINCREMENT,$columnName TEXT NOT NULL)");
    await db.execute("CREATE TABLE $dbtablesecond ($columnid INTEGER PRIMARY KEY AUTOINCREMENT,$columnName TEXT NOT NULL)");
    await db.execute("CREATE TABLE $dbtablethird ($columnid INTEGER PRIMARY KEY AUTOINCREMENT,$columnName TEXT NOT NULL)");
    //  await db.execute("CREATE TABLE GroupThird (id INTEGER PRIMARY KEY AUTOINCREMENT,message TEXT NOT NULL");
  }

   insertrecord(Map<String,dynamic> row,int index) async{
    //for inserting entries
     if(index==0){
       Database? db =await instance.database;
       return await db?.insert(dbtable, row);
     }
     else if(index==1){
       Database? db =await instance.database;
       return await db?.insert(dbtablesecond, row);
     }
     else if(index==2) {
       Database? db =await instance.database;
       return await db?.insert(dbtablethird, row);
     }
     }


  Future<List<Map<String,dynamic>>> queryDatabase(int index)async{
    Database? db =await instance.database;
    if(index==0){
      return await db!.query(dbtable);
    }
   else if(index==1){
     return await db!.query(dbtablesecond);
    }
   else
     return await db!.query(dbtablethird);
  }

  // Future<int>update(Map<String,dynamic> row) async {
  //   Database? db =await instance.database;
  //   int id=row[columnid];
  //   return await db!.update(dbtable, row,where: "$columnid=?",whereArgs: [id]);
  // }
}