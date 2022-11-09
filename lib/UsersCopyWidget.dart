import 'package:banking/Transfer.dart';
import 'package:banking/UserWidget.dart';
import 'package:banking/UserprofileWidget.dart';
import 'package:banking/main.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:banking/Users.dart';
import 'package:path/path.dart' as Path;

class UsersCopyWidget extends StatefulWidget {
  const UsersCopyWidget(
      this.name,
      this.amount,
      this.textz,
      this.image,
      this.ids,
      this.email
      );

  final String? textz;
  final String? name;
  final int? amount;
  final int? ids;
  final String? email;
  final String? image;

  @override
  _UsersCopyWidget createState() => _UsersCopyWidget(name,amount,textz,ids,email,image);
}

class _UsersCopyWidget extends State<UsersCopyWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override

  _UsersCopyWidget(
      this.name,
      this.amount,
      this.textz,
      this.ids,
      this.email,
      this.image
      );

  final String? textz;
  final String? name;
  final int? amount;
  final int? ids;
  final String? email;
  final String? image;



  Future<void> insertDog(Transfer dog) async {
    final db = await openDatabase(
      Path.join(await getDatabasesPath(), 'transfer.db'),
      onCreate: (db, version) {
        return db.execute(
          'SELECT * FROM transfer',
        );
      },
      version: 1,
    );
    await db.insert(
      'transfer',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Users>> fetchdata() async{
    final database = await openDatabase(
      Path.join(await getDatabasesPath(), 'users.db'),
      onCreate: (db, version) {
        return db.execute(
          'SELECT * FROM users',
        );
      },
      version: 1,
    );

    final List<Map<String,dynamic>> queryresult = await database.query('users');
    return List.generate(queryresult.length, (i) {
      return Users(
          id: queryresult[i]['id'],
          name: queryresult[i]['name'],
          email: queryresult[i]['email'],
          amount: queryresult[i]['amount'],
          image: queryresult[i]['image']
      );
    });
  }

  Future<void> updateUser(Users dog,int id) async {
    // Get a reference to the database.
    final db = await openDatabase(
      Path.join(await getDatabasesPath(), 'users.db'),
      onCreate: (db, version) {
        return db.execute(
          'SELECT * FROM users',
        );
      },
      version: 1,
    );
    // Update the given Dog.
    await db.update(
      'users',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        title: Text(
          'Banking Choose customer',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FutureBuilder(
                    future: fetchdata(),
                    builder: (BuildContext context,AsyncSnapshot snapshot){
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:snapshot.data.length,
                          itemBuilder:(context,index){
                            if(snapshot.hasData){
                              Users data = snapshot.data[index];
                              final am = data.amount;
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                                child: InkWell(
                                  onTap: ()async{
                                    //here is where you have to update receiver
                                    var one = Users(
                                        id: data.id,
                                        name: data.name,
                                        email: data.email,
                                        amount: data.amount+int.parse(textz!),
                                        image: data.image,
                                    );
                                    await updateUser(one,data.id);
                                    //here is where you have to update receiver
                                    var two = Users(
                                      id: ids!,
                                      name: name!,
                                      email: email!,
                                      amount: amount!-int.parse(textz!),
                                      image: image!,
                                    );
                                    await updateUser(two,ids!);


                                    //here is where you have to insert entry in transfer table

                                    var bolo = Transfer(
                                        sender: name!,
                                        receiver: data.name,
                                        amount: int.parse(textz!),
                                    );
                                    await insertDog(bolo);

                                    await Navigator.push(context, MaterialPageRoute(builder: (context) =>UsersWidget(),));
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0xFFF5F5F5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                          child: Container(
                                            width: 40,
                                            height: 45,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(data.image),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                              child: Text(
                                                data.name,
                                              ),
                                            ),
                                            Text("$am",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            else{
                              return Center(child: Text("No users found"),);
                            }
                          }
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
