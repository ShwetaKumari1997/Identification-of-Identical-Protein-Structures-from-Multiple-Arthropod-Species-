import 'dart:html';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:protein_database/models/data_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:protein_database/models/just_try_model.dart';
import 'package:protein_database/models/user_model.dart';
import 'package:protein_database/services/static_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiServices{

  final _auth = FirebaseAuth.instance;

  Future<void> addDataTODB( {required Map<String,dynamic> mapData, required Uint8List pdb ,required String pdbName, required Uint8List pdf, required String pdfName} ) async{
    mapData["pdb"] = await uploadPDB(pdb,pdbName);
    mapData["pdf"] = await uploadPDF(pdf,pdfName);
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("DATA");
    await collectionReference.add(mapData);
    await fetchAllData();
  }

  Future<void> updateTODB({required Map<String,dynamic> mapData,  Uint8List? pdb ,required String pdbName,  Uint8List? pdf, required String pdfName, required int index}) async{
    if(pdb == null){mapData["pdb"] = StaticData.allData[index].pdb;} else{mapData["pdb"] = await uploadPDB(pdb,pdbName);}
    if(pdf == null){mapData["pdf"] = StaticData.allData[index].pdf;} else{mapData["pdf"] = await uploadPDF(pdf,pdfName);}
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("DATA");
    QuerySnapshot querySnapshot = await collectionReference.get();
    await querySnapshot.docs[index].reference.update(mapData);
    await fetchAllData();
  }

  Future<String> uploadPDB(Uint8List pdb, String pdbName) async{
    Reference reference = FirebaseStorage.instance.ref().child('files/PDB/$pdbName');
    TaskSnapshot uploadTask = await reference.putData(pdb);
    String url = await uploadTask.ref.getDownloadURL();
    return url;
  }

  Future<String> uploadPDF(Uint8List pdf, String pdfName) async{
    Reference reference = FirebaseStorage.instance.ref().child('files/PDF/$pdfName');
    TaskSnapshot uploadTask = await reference.putData(pdf);
    String url = await uploadTask.ref.getDownloadURL();
    return url;
  }

  Future<void> fetchAllData() async {
    List<DataModel> data = [];
    CollectionReference reference = FirebaseFirestore.instance.collection("DATA");
    QuerySnapshot querySnapshot = await reference.get();
    querySnapshot.docs.forEach((element) {
      Map<String,dynamic> Rdata = element.data() as Map<String,dynamic>;
      Rdata = element.data() as Map<String,dynamic>;
      print("data received "+ Rdata.toString());
      data.add(DataModel.fromJson(element.data() as Map<String,dynamic>));
    });
    print("dwadawdawdawd");
    StaticData.allData = data;
  }

  Future<void> deleteData(int index) async {
    CollectionReference reference = FirebaseFirestore.instance.collection("DATA");
    QuerySnapshot querySnapshot = await reference.get();
    await querySnapshot.docs[index].reference.delete();
  }

  Future<String> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "no user found";
      } else if (e.code == 'wrong-password') {
        return "wrong password";
      }
    }
    return "Enter valid user name password and try again";
  }

  Future<String> signupUser(String email,String password,String name) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveUserData(email, name);
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }

    return "Something went wrong please try again";
  }

  Future<void> saveUserData(String email,String name) async {
    String? uid =  _auth.currentUser?.uid;
    if(uid != null) {
      UserModel userModel = UserModel(
          uid: uid,
          email: email,
          name: name,
          isAdmin: false);
      CollectionReference reference = FirebaseFirestore.instance.collection("USERS");
      await reference.doc(uid).set(userModel.toJson());
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  Future<void> getUserData() async{
    DocumentSnapshot data = await FirebaseFirestore.instance.collection("USERS").doc(_auth.currentUser?.uid).get();
    print("data initialization");
    StaticData.userData = UserModel.fromJson(data.data() as Map<String,dynamic>);
    print("dooonnnnneeee");
  }

  Future<void> downloadData(String url) async {
    final httpRef = FirebaseStorage.instance.refFromURL(url);
    AnchorElement anchorElement = AnchorElement(href: url);
    anchorElement.download = httpRef.name;
    anchorElement.click();
  }
  
  Future<void> uploadTryData()async {
    print("Started uploading");
    CollectionReference reference = FirebaseFirestore.instance.collection("TRY");
    StaticData.trydata.forEach((element) async {
      JustTry data = JustTry.fromJson(element as Map<String,dynamic>);
      await reference.add(data.toJson());
    });
    print("done uploading");
  }

}
