import 'package:banking/UserprofileWidget.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:banking/Users.dart';


class UsersWidget extends StatefulWidget {
  const UsersWidget({Key? key}) : super(key: key);

  @override
  State<UsersWidget> createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<UsersWidget> {
  @override
  void initState() {
    fetchdata();
    super.initState();
  }
  @override

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


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        title: Text(
          'Banking Users',
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
            child: FutureBuilder(
              future: fetchdata(),
                builder: (BuildContext context,AsyncSnapshot snapshot){
              return Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:snapshot.data.length,
                    itemBuilder:(context,index){
                     if(snapshot.hasData){
                      return display(snapshot.data[index],context);
                     }
                    else{
                      return Center(child: Text("No users found"),);
                    }
                  }
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

Widget display(Users data,BuildContext context){
  final am = data.amount;
  return Card(
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
            width: 50,
            height: 50,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              data.image
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding:
              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
              child: Text(
                data.name
              ),
            ),
            Text(
              "$am"
            ),
          ],
        ),
        IconButton(
          onPressed: () async{
            final isss = data.id;
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserprofileWidget(data.amount,data.image,data.name,"$isss",data.email),));
          },
          icon: Icon(
          Icons.arrow_forward,
          color: Colors.black,
          size: 24,
        ),)
      ],
    ),
  );
}