import 'package:flutter/material.dart';
import 'package:flutter_login_demo/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// firebase realtime database
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  String _user_val = "";
  String _user_body = "";
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter login demo'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: signOut)
        ],
      ),
      body: CenterForm(context),
    );
  }

  Widget CenterForm(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return new Form(
      child: ListView(
        key: _formkey,
        children: <Widget>[
          valuInput(),
          userbodyinput(),
          Container(
            margin: new EdgeInsets.only(top: 4),
            child: RaisedButton(
              child: Text("Add to Firestore"),
              onPressed: () {
                firestoreAdd();
              },
            ),
          )
        ],
      ),
    );
  }

  final databaseRef = Firestore.instance;

  List<String> users = [];
  void firestoreAdd() async {
    DocumentReference ref = await databaseRef
        .collection("comments")
        .add({"title": "sdsdsds", "body": "Sds"});
    print(ref.documentID);
    print("the data is successfully added");
    retreiveData();
  }

  void retreiveData() {
    databaseRef.collection("comments").getDocuments().then(
        (QuerySnapshot snap) =>
            {snap.documents.forEach((f) => print('${f.data}}'))});
  }

  Widget userbodyinput() {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLength: 100,
        maxLines: 10,
        keyboardType: TextInputType.text,
        autofocus: true,
        autocorrect: true,
        decoration: new InputDecoration(
          hintText: "Describe yourself",
          icon: new Icon(Icons.text_fields, color: Colors.black),
        ),
        validator: (value) => value.isEmpty ? "THE Body cannot be empty" : null,
        onSaved: (value) => _user_body = value.toLowerCase().trim(),
      ),
    );
  }

  Widget valuInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 2,
        keyboardType: TextInputType.text,
        autofocus: true,
        decoration: new InputDecoration(
            hintText: 'user Body',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) =>
            value.isEmpty ? 'The username cannot be empty' : null,
        onSaved: (value) => _user_val = value.trim(),
      ),
    );
  }
}
