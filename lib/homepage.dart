import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'services/crudModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String carModel;
  String carColor;
  String url;
  CrudModel crudObj = new CrudModel();
  File _image;    
  var cars;

  //selecting image from gallery
  Future chooseFile() async {    
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {    
      setState(() {    
        _image = image;    
      });    
    });    
  }  

//uploading image and saving url
  Future uploadFile() async {    
    StorageReference storageReference = FirebaseStorage.instance    
        .ref()    
        .child('images/');    
    StorageUploadTask uploadTask = storageReference.putFile(_image);    
    await uploadTask.onComplete;    
    print('File Uploaded');    
    storageReference.getDownloadURL().then((fileURL) {    
      setState(() {    
        url = fileURL;    
      });    
    });    
  }  

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Data', style: TextStyle(fontSize: 15.0)),
            content: Container(
              height: 200.0,
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter car Name'),
                    onChanged: (value) {
                      this.carModel = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter car color'),
                    onChanged: (value) {
                      this.carColor = value;
                    },
                  ),   
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () {
                  //uploading data-----------------------------------
                  Navigator.of(context).pop();
                  crudObj.addData({
                    'carName': this.carModel,
                    'color': this.carColor,
                    'url': this.url
                  }).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Job done', style: TextStyle(fontSize: 15.0)),
            content: Text('added'),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<bool> updateDialog(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Data', style: TextStyle(fontSize: 15.0)),
            content: Container(
              height: 125.0,
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter car Name'),
                    onChanged: (value) {
                      this.carModel = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter car color'),
                    onChanged: (value) {
                      this.carColor = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Update'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.updateData(selectedDoc, {
                    'carName': this.carModel,
                    'color': this.carColor
                  }).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    crudObj.getData().then((results) {
      setState(() {
        cars = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Crud operation"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((onValue) {
                  Navigator.of(context).pushReplacementNamed('/landingpage');
                }).catchError((onError) {
                  print(onError);
                });
              },
            ),
          ],
        ),
        body:SingleChildScrollView(    
       child: Column( 
         crossAxisAlignment: CrossAxisAlignment.start,   
         children: <Widget>[    
           TextField(
                    decoration: InputDecoration(hintText: 'Enter car Name'),
                    onChanged: (value) {
                      this.carModel = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter car color'),
                    onChanged: (value) {
                      this.carColor = value;
                    },
                  ), 
           Text('Selected Image'),    
           _image != null    
               ? Image.asset(    
                   _image.path,    
                   height: 150,    
                 )    
               : Container(height: 150),    
           _image == null    
               ? RaisedButton(    
                   child: Text('Choose File'),    
                   onPressed: chooseFile,    
                   color: Colors.cyan,    
                 )    
               : Container(),    
           _image != null    
               ? RaisedButton(    
                   child: Text('Upload File'),    
                   onPressed: uploadFile,    
                   color: Colors.cyan,    
                 )    
               : Container(),     
           Text('Uploaded Image'),    
           url != null    
               ? Image.network(    
                   url,    
                   height: 150,    
                 )    
               : Container(), 
            FlatButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () {
                  uploadFile();
                  // Navigator.of(context).pop();
                  crudObj.addData({
                    'carName': this.carModel,
                    'color': this.carColor,
                    'url': this.url
                  }).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),
         ],    
       ),  
      ),  
        // floatingActionButton: new FloatingActionButton(
        //     elevation: 0.0,
        //     child: new Icon(Icons.add),
        //     onPressed: () {
        //       addDialog(context);
        //     })
            );
  }

  Widget _carList() {
    if (cars != null) {
      return StreamBuilder(
        stream: cars,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                return new ListTile(
                  title: Text(snapshot.data.documents[i].data['carName']),
                  subtitle: Text(snapshot.data.documents[i].data['color']),
                  onTap: () {
                    updateDialog(
                        context, snapshot.data.documents[i].documentID);
                  },
                  onLongPress: () {
                    crudObj.deleteData(snapshot.data.documents[i].documentID);
                  },
                );
              },
            );
          }
          return Text('Not data');
        },
      );
    } else {
      return Text('Loading, Please wait..');
    }
  }
}
