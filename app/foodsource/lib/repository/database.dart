import 'dart:async';
import 'dart:io';
import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/common/session.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path_provider/path_provider.dart';

//TODO: Change this name:
class DBHelper {
  Database _db;
  final int dbVersion = 1;
  final String path = "fieldcheck.db";
  final _lock = new Lock();

  final migrations = new Migrations();

  static final DBHelper _dbHelper = new DBHelper._internal();

  factory DBHelper() {
    _dbHelper._init();
    return _dbHelper;
  }

  DBHelper._internal();

  Future<Map> getEntity(String entityTableName, String id) async {
    await getDatabase();

    var returnedValue =
        await getEntityWithWhere(entityTableName, 'id = ?', [id]);
    if (returnedValue.length > 0) {
      return returnedValue.first;
    }
    return null;
  }

  Future<List<Map>> getEntityWithWhere(String entityTableName,
      String whereClause, List<dynamic> parameters) async {
    await getDatabase();

    List<Map> maps = new List();
    maps = await _db.query(entityTableName,
        columns: ['*'], where: whereClause, whereArgs: parameters);
    return maps;
  }

  Future<List<Map>> getEntitiesWithWhere(String entityTableName,
      {String whereClause, List<dynamic> parameters}) async {
    await getDatabase();

    List<Map> maps = new List();
    maps = await _db.query(entityTableName,
        columns: ['*'], where: whereClause, whereArgs: parameters);
    return maps;
  }

  Future<bool> doesExist(String entityTableName, String id) async {
    await getDatabase();

    List<Map> maps = await _db.query(entityTableName,
        columns: ['id'], where: "id = ?", whereArgs: [id]);
    var doesExist = maps != null && maps.length > 0;
    return doesExist;
  }

  Future<int> delete<T extends BaseEntity>(T entity) async {
    return await _db
        .delete(entity.tableName, where: "id = ?", whereArgs: [entity.id]);
  }

  Future<BaseEntity> insert(BaseEntity entity, bool isChanged) async {
    await getDatabase();

    entity.createdDate = new DateTime.now();
    if (Session().employee == null) {
      entity.createdBy = 'system';
    } else {
      entity.createdBy = Session().employee.user.login;
    }
    entity.lastModifiedDate = new DateTime.now();
    if (Session().employee == null) {
      entity.lastModifiedBy = 'system';
    } else {
      entity.lastModifiedBy = Session().employee.user.login;
    }

    entity.isChanged = isChanged;

    var map = _generateMap(entity);

    entity.localId = await _db.insert(entity.tableName, map);

    return entity;
  }

  Future<int> update(BaseEntity entity, bool isChanged) async {
    await getDatabase();

    entity.lastModifiedDate = new DateTime.now();
    if (Session().employee == null) {
      entity.lastModifiedBy = 'system';
    } else {
      entity.lastModifiedBy = Session().employee.user.login;
    }
    entity.isChanged = isChanged;

    var map = _generateMap(entity);

    var result = await _db
        .update(entity.tableName, map, where: "id = ?", whereArgs: [entity.id]);
    return result;
  }

  OnDatabaseCreateFn onCreate;
  OnDatabaseConfigureFn onConfigure;
  OnDatabaseVersionChangeFn onDowngrade;
  OnDatabaseVersionChangeFn onUpgrade;
  OnDatabaseOpenFn onOpen;

  _init() {
    onConfigure = (Database db) {
      print("onConfigure");
    };

    onCreate = (Database db, int version) async {
      print("onCreate");

      for (int cnt = 1; cnt <= version; cnt++) {
        if (!Migrations.versions.containsKey(cnt)) {
          print('Migration for database version ($cnt) not found');
          continue;
        }

        var migrationScripts = Migrations.versions[cnt];

        for (var script in migrationScripts) {
          await db.execute(script);
        }
      }
    };

    onOpen = (Database db) {
      print("onOpen");
    };

    onUpgrade = (Database db, int oldVersion, int newVersion) async {
      print("onUpgrade");

      for (int cnt = oldVersion + 1; cnt <= newVersion; cnt++) {
        if (!Migrations.versions.containsKey(cnt)) {
          print('Migration for database version ($cnt) not found');
          continue;
        }

        var migrationScripts = Migrations.versions[cnt];

        for (var script in migrationScripts) {
          await db.execute(script);
        }
      }
    };

    onDowngrade = (Database db, int oldVersion, int newVersion) {
      //TODO: Doen die downgrades hier met n loop
      print("onDowngrade");
    };
  }

  Future<Database> _open(String path, int version) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //change 
    String path = join(documentsDirectory.path, "foodsource.db");

    return openDatabase(path,
        version: version,
        onConfigure: onConfigure,
        onCreate: onCreate,
        onUpgrade: onUpgrade,
        onDowngrade: onDowngrade,
        onOpen: onOpen);
  }

  Future close() async => _db.close();

  Future<Database> getDatabase() async {
    if (_db == null) {
      await _lock.synchronized(
        () async {
          //Check again once entering the synchronized block
          if (_db == null) {
            _db = await _open(this.path, this.dbVersion);
          }
        }, //timeout: new Duration(seconds: 2)
      );
    }
    return _db;
  }

  Map _generateMap(BaseEntity entity) {
    var map = entity.toMap();
    var keysToRemove = new List<String>();
    for (var key in map.keys) {
      if (map[key] is Map) {
        keysToRemove.add(key);
      }
    }
    keysToRemove.forEach((key) => map.remove(key));
    return map;
  }
}

class Migrations {
  static Map<int, List<String>> versions = new Map<int, List<String>>();

  Migrations() {
    _init();
  }

  _init() {
    List<String> v1Scripts = new List<String>();
    versions[1] = v1Scripts;
    v1Scripts.add('''
          create table Employees (
              localId integer primary key autoincrement,
              id text unique not null, 
              isDeleted int not null default 0,
              isChanged bool not null,
              createdBy text null,
              createdDate text null,
              lastModifiedBy text null,
              lastModifiedDate text null,
              displayName text not null,
              mobileNumber text null,
              userId text not null,
              companyId text null
              );          
      ''');
    v1Scripts.add('''
          create table Users (
              localId integer primary key autoincrement,
              id text unique not null, 
              isDeleted int not null default 0,
              isChanged bool not null default 0,
              createdBy text null,
              createdDate text null,
              lastModifiedBy text null,
              lastModifiedDate text null,
              firstName text not null,
              lastName text not null,
              login text not null,
              email text null,
              imageUrl text null,
              accessToken text null,
              localPassword text null
              );
      ''');
    v1Scripts.add('''
          create table Jobs (
              localId integer primary key autoincrement,
              id text unique not null, 
              isDeleted int not null default 0,
              isChanged bool not null,
              createdBy text null,
              createdDate text null,
              lastModifiedBy text null,
              lastModifiedDate text null,
              jobNumber text not null,
              description text null,
              status text null,
              statusId text null,
              scheduledDate text null,
              startDate text null,
              completedDate text null,
              notes text null,
              title text null,
              rescheduled bool null,
              employeeId text null,
              scheduleId text not null,
              targetId text null,
              addressId text null
              );          
      ''');
    v1Scripts.add('''
          create table ClientGroups (
              localId integer primary key autoincrement,
              id text unique not null, 
              isDeleted int not null default 0,
              isChanged bool not null default 0,
              createdBy text null,
              createdDate text null,
              lastModifiedBy text null,
              lastModifiedDate text null,
              name text not null
              );          
      ''');
    v1Scripts.add('''
          create table Clients (
              localId integer primary key autoincrement,
              id text unique not null, 
              isDeleted int not null default 0,
              isChanged bool not null default 0,
              createdBy text null,
              createdDate text null,
              lastModifiedBy text null,
              lastModifiedDate text null,
              name text not null,
              clientGroupId text null
              );          
      ''');
    v1Scripts.add('''
          create table Companies (
              localId integer primary key autoincrement,
              id text unique not null, 
              isDeleted int not null default 0,
              isChanged bool not null default 0,
              createdBy text null,
              createdDate text null,
              lastModifiedBy text null,
              lastModifiedDate text null,
              name text not null,
              description text null
              );          
      ''');
    v1Scripts.add('''
          create table Checklists (
              localId integer primary key autoincrement,
              id text unique not null,
              isDeleted int not null default 0,
              isChanged bool not null default 0,
              createdBy text null,
              createdDate text null,
              lastModifiedBy text null,
              lastModifiedDate text null,
              startDate text null,
              endDate text null,
              name text not null,
              mandatory boolean,
              priority integer,
              targetId text null,
              clientId text null,
              clientGroupId text null
              );
      ''');
    v1Scripts.add('''
          create table Sections (
              localId integer primary key autoincrement,
              id text unique not null,
              isDeleted int not null default 0,
              isChanged bool not null default 0,
              createdBy text null,
              createdDate text null,
              lastModifiedBy text null,
              lastModifiedDate text null,
              startDate text null,
              endDate text null,
              name text not null,
              ordering integer,
              checklistId text null
              );
      ''');
    v1Scripts.add('''
          create table Questions (
              localId integer primary key autoincrement,
              id text unique not null,
              isDeleted int not null default 0,
              isChanged bool not null default 0,
              createdBy text null,
              createdDate text null,
              lastModifiedBy text null,
              lastModifiedDate text null,
              startDate text null,
              endDate text null,
              name text not null,
              ordering integer,
              type text null,
              sectionId text null
              );
      ''');
    v1Scripts.add('''
     create table Images (
        localId integer primary key autoincrement,
        id text unique not null,
        isDeleted int not null default 0,
        isChanged bool not null default 0,
        createdBy text null,
        createdDate text null,
        lastModifiedBy text null,
        lastModifiedDate text null,
        fileName text null,
        latitude real null,
        longitude real null,
        image blob not null,
        imageContentType text null,
        jobId text null,
        targetId text null
        );      
      ''');
    v1Scripts.add('''   
      create table Schedules (
        localId integer primary key autoincrement,
        id text unique not null,
        isDeleted int not null default 0,
        isChanged bool not null,
        createdBy text null,
        createdDate text null,
        lastModifiedBy text null,
        lastModifiedDate text null,
        ical text not null,
        targetId text not null,
        employeeId text not null,
        jobSubTypeId text not null
      );    
    ''');
    v1Scripts.add('''   
      create table Targets (
        localId integer primary key autoincrement,
        id text unique not null,
        isDeleted int not null default 0,
        isChanged bool not null,
        createdBy text null,
        createdDate text null,
        lastModifiedBy text null,
        lastModifiedDate text null,
        name text not null,
        description text not null,
        clientId text not null,
        addressId text not null,
        targetTypeId text not null
      );    
    ''');
    v1Scripts.add('''   
      create table TargetTypes (
        localId integer primary key autoincrement,
        id text unique not null,
        isDeleted int not null default 0,
        isChanged bool not null,
        createdBy text null,
        createdDate text null,
        lastModifiedBy text null,
        lastModifiedDate text null,
        name text not null,
        description text not null
      );    
    ''');
    v1Scripts.add('''   
      create table ChecklistJobStateLink (
        localId integer primary key autoincrement,
        id text unique not null,
        isDeleted int not null default 0,
        isChanged bool not null,
        createdBy text null,
        createdDate text null,
        lastModifiedBy text null,
        lastModifiedDate text null,
        checklistType text not null,
        jobStatus text not null,
        isEnabled bool not null,
        displayOrder int null
      );    
    ''');
    v1Scripts.add('''   
      create table JobStatusLog (
        localId integer primary key autoincrement,
        id text unique not null,
        isDeleted int not null default 0,
        isChanged bool not null,
        createdBy text null,
        createdDate text null,
        lastModifiedBy text null,
        lastModifiedDate text null,
        jobId text not null,
        oldStatus text null,
        newStatus text null,
        transitionDate text null,
        latitude real null,
        longitude real null
      );    
    ''');
    v1Scripts.add('''   
      create table Address (
        localId integer primary key autoincrement,
        id text unique not null,
        isDeleted int not null default 0,
        isChanged bool not null,
        createdBy text null,
        createdDate text null,
        lastModifiedBy text null,
        lastModifiedDate text null,
        name text null,
        addressLine1 text null,
        addressLine2 text null,
        postalCode text null,
        provinceState text null,
        country text null,
        latitude decimal null,
        longitude decimal null
      );    
    ''');
    v1Scripts.add('''   
    create table Comments (
        localId integer primary key autoincrement,
        id text unique not null,
        isDeleted int not null default 0,
        isChanged bool not null,
        createdBy text null,
        createdDate text null,
        lastModifiedBy text null,
        lastModifiedDate text null,
        title text null,
        comment text null,
        jobId text null,
        employeeId text null
      );  
    ''');
    v1Scripts.add('''   
    create table ServiceKitTemplates (
        localId integer primary key autoincrement,
        id text unique not null,
        isDeleted int not null default 0,
        isChanged bool not null,
        createdBy text null,
        createdDate text null,
        lastModifiedBy text null,
        lastModifiedDate text null,
        name text null,
        assetTypeId text null,
        jobSubTypeId text null
      );  
    ''');
    v1Scripts.add('''
      create table ServiceKitTemplateItems (
        localId integer primary key autoincrement,
        id text unique not null,
        isDeleted int not null default 0,
        isChanged bool not null,
        createdBy text null,
        createdDate text null,
        lastModifiedBy text null,
        lastModifiedDate text null,
        name text null,
        quantity integer null,
        serviceKitTemplateId text not null
      );    
    ''');

  }
}

/* Create table template
    v??Scripts.add('''
      create table $YOUR_TABLE_NAME_HERE (
        localId integer primary key autoincrement,
        id text unique not null,
        isDeleted int not null default 0,
        isChanged bool not null,
        createdBy text null,
        createdDate text null,
        lastModifiedBy text null,
        lastModifiedDate text null,
        ////add your columns here
      );    
    ''');
*/
