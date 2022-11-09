import 'package:banking/UsersCopyWidget.dart';
import 'package:flutter/material.dart';

class UserprofileWidget extends StatefulWidget {
  const UserprofileWidget(
      this.amount,
      this.image,
      this.name,
      this.ids,
      this.email,
      );

  final String? image;
  final String? name;
  final int? amount;
  final String? ids;
  final String? email;

  @override
  _UserprofileWidgetState createState() => _UserprofileWidgetState(amount,image,name,ids,email);
}

class _UserprofileWidgetState extends State<UserprofileWidget> {

  _UserprofileWidgetState(
      this.amount,
      this.image,
      this.name,
      this.id,
      this.email
  );
  final String? image;
  final String? name;
  final int? amount;
  final String? id;
  final String? email;
  TextEditingController textController = TextEditingController();
  String val = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        title: Text(
          'Banking Profile',
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 200),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: Container(
                            width: 120,
                            height: 120,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(image!),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: Text(
                            name!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                           "$amount",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(50, 0, 20, 20),
                    child: TextField(
                      controller: textController,
                      onChanged: (text){
                        val = text;
                      },
                    )
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: Colors.orange,
                        onPressed: () async {
                          if(amount! >= int.parse(val)){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>UsersCopyWidget(name,amount,val,image,int.parse(id!),email),));
                          }
                        },
                        child:Text('Transfer Money',style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
