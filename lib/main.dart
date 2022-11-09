import 'package:banking/Transfer.dart';
import 'package:banking/UserWidget.dart';
import 'package:banking/Users.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'users.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email Text,amount INTEGER, image TEXT)',
      );
    },
    version: 1,
  );
  final database1 = openDatabase(
    join(await getDatabasesPath(), 'transfer.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE transfer(sender TEXT, receiver Text,amount INTEGER)',
      );
    },
    version: 1,
  );
  Future<void> insertuser(Transfer users) async {
    final db = await database1;
    await db.insert(
      'transfer',
      users.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> insertDog(Users users) async {
    final db = await database;
    await db.insert(
      'users',
      users.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  var one = const Users(
    id: 0,
    name: 'Fido1',
    email: 'fido1@gmail.com',
    amount: 100,
    image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  );
  var dummy = Transfer(
      sender: 'sender',
      receiver: 'receiver',
      amount: 100,
  );
  var two = const Users(
      id: 2,
      name: 'Fido2',
      email: 'fido2@gmail.com',
      amount: 200,
      image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  );
  var three = const Users(
      id: 3,
      name: 'Fido3',
      email: 'fido3@gmail.com',
      amount: 300,
      image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  );
  var four = const Users(
      id: 4,
      name: 'Fido4',
      email: 'fido4@gmail.com',
      amount: 400,
      image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  );
  var five = const Users(
      id: 5,
      name: 'Fido5',
      email: 'fido5@gmail.com',
      amount: 500,
      image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  );
  var six = const Users(
      id: 6,
      name: 'Fido6',
      email: 'fido6@gmail.com',
      amount: 600,
      image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  );
  var seven = const Users(
      id: 7,
      name: 'Fido7',
      email: 'fido7@gmail.com',
      amount: 700,
      image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  );
  var eight = const Users(
      id: 8,
      name: 'Fido8',
      email: 'fido8@gmail.com',
      amount: 800,
      image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  );
  var nine = const Users(
      id: 9,
      name: 'Fido9',
      email: 'fido9@gmail.com',
      amount: 900,
      image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  );
  var ten = const Users(
      id: 10,
      name: 'Fido10',
      email: 'fido10@gmail.com',
      amount: 1000,
      image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
  );
  await insertDog(one);
  await insertDog(two);
  await insertDog(three);
  await insertDog(four);
  await insertDog(five);
  await insertDog(six);
  await insertDog(seven);
  await insertDog(eight);
  await insertDog(nine);
  await insertDog(ten);
  await insertuser(dummy);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePageWidget(),
    );
  }
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        title: Text(
          'Banking App',
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Text(
                      '\"This is simple banking app that lets\'s bank managers to transfer funds across accounts\"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Text(
                      '\"You can get everything in life you want if you will just help enough other people get what they want.\"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>UsersWidget(),));
                },
                color: Colors.orange,
                child:Text('View Customer',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
