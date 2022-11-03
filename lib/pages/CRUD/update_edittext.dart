import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:protein_database/services/static_data.dart';

import '../../services/api_services.dart';
import '../../utils/colors.dart';
import '../../widgets/edit_text.dart';
import '../../widgets/edit_text1.dart';
import '../../widgets/headers/header.dart';
import '../../widgets/headers/main_header.dart';
enum booldata { yes, no, none }

class UpdateEditText extends StatefulWidget {
  const UpdateEditText({Key? key}) : super(key: key);

  @override
  State<UpdateEditText> createState() => _UpdateEditTextState();
}

class _UpdateEditTextState extends State<UpdateEditText> {
  late int recIndex;
  late String data1;
  Map<String,dynamic> data = Map();
  bool isLoading = false;
  String validation = "yes";
  ApiServices apiServices = ApiServices();
  booldata _booldata = booldata.yes;
  final _formKey = GlobalKey<FormState>();
  late Uint8List  pdbFile;
  late Uint8List  pdfFile;
  String fileName1 = "uploaded.pdb";
  String fileName2 = "uploaded.pdf";

  @override
  void initState(){
    super.initState();
    if(StaticData.userData.name == "not initialized"){
      Navigator.pushReplacementNamed(context, '/login');
    }else if(!StaticData.userData.isAdmin){
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  //controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController orgController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController massController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController functionController = TextEditingController();
  TextEditingController scoreController = TextEditingController();
  TextEditingController xController = TextEditingController();
  TextEditingController yController = TextEditingController();
  TextEditingController zController = TextEditingController();
  TextEditingController resController = TextEditingController();

  setInitialData(){
    nameController.text = StaticData.allData[recIndex].Name;
    idController.text = StaticData.allData[recIndex].UniProtID;
    orgController.text = StaticData.allData[recIndex].Organism;
    typeController.text = StaticData.allData[recIndex].Type;
    massController.text = StaticData.allData[recIndex].Mass;
    lengthController.text = StaticData.allData[recIndex].Length;
    functionController.text = StaticData.allData[recIndex].Function;
    scoreController.text = StaticData.allData[recIndex].Score;
    xController.text = StaticData.allData[recIndex].XAxis;
    yController.text = StaticData.allData[recIndex].YAxis;
    zController.text = StaticData.allData[recIndex].ZAxis;
    resController.text = StaticData.allData[recIndex].Residues;
    validation = StaticData.allData[recIndex].Validity;
    if(validation == "yes"){
      _booldata = booldata.yes;
    }else if(validation == "no"){
      _booldata = booldata.no;
    }else{
      _booldata = booldata.none;
    }
  }

  void choosePDB() async{
    final result = await FilePicker.platform.pickFiles(allowMultiple: false,allowedExtensions: ['pdb'],type: FileType.custom);
    if(result == null) return;
    setState((){
      print("pdb selecterd = " + result.files.single.name);
      pdbFile = result.files.single.bytes!;
      fileName1 = result.files.single.name;
    });
  }

  void choosePDF() async{
    final result = await FilePicker.platform.pickFiles(allowMultiple: false,allowedExtensions: ['pdf'],type: FileType.custom);
    if(result == null) return;
    setState((){
      print("pdf selecterd = " + result.files.single.name);
      pdfFile = result.files.single.bytes!;
      fileName2 = result.files.single.name;
    });
  }

  void updateData(){
    if(_formKey.currentState!.validate()){
      if(fileName1 != "No file choosen"){
        if(fileName2 != "No file choosen"){
          _formKey.currentState!.save();
          data["Validity"] = validation;
          setState((){isLoading = true;});
          if(fileName1 == "uploaded.pdb" && fileName2 == "uploaded.pdf") {
            apiServices.updateTODB(mapData: data,
                pdbName: fileName1,
                pdfName: fileName2,
                index: recIndex);
          }else if(fileName1 == "uploaded.pdb" && fileName2 != "uploaded.pdf") {
            apiServices.updateTODB(mapData: data,
                pdbName: fileName1,
                pdf: pdfFile,
                pdfName: fileName2,
                index: recIndex);
          }else if(fileName1 != "uploaded.pdb" && fileName2 == "uploaded.pdf") {
            apiServices.updateTODB(mapData: data,
                pdb: pdbFile,
                pdbName: fileName1,
                pdfName: fileName2,
                index: recIndex);
          }else{
            apiServices.updateTODB(mapData: data,
                pdb: pdbFile,
                pdbName: fileName1,
                pdf: pdfFile,
                pdfName: fileName2,
                index: recIndex);
          }
          setState((){isLoading = false;});
          errorDisplay("update completed");
          Navigator.pop(context);
        }else{
          errorDisplay("choose pdf file to upload");
        }
      }else{
        errorDisplay("choose pdb file to upload");
      }
    }
  }



  void errorDisplay(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }



  @override
  Widget build(BuildContext context) {
    recIndex = ModalRoute.of(context)!.settings.arguments as int;
    setInitialData();
    return LayoutBuilder(
        builder: (context, constraint) {
          if (constraint.maxWidth > 1200) {
            return DesktopView();
          } else if (constraint.maxWidth > 800 && constraint.maxWidth < 1200) {
            return DesktopView();
          } else {
            return MobileView();
          }
        }
    );
  }

  Widget DesktopView(){
    return SafeArea(
        child: Scaffold(
          backgroundColor: CustomeColors.bg_color5_1,
          body: SingleChildScrollView(
            child: Container(
              child: Center(
                child: Container(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Header(backPressed: () { Navigator.pop(context); }, headerText: StaticData.allData[recIndex].Name,backgroundColor: CustomeColors.bg_color5,),
                            SizedBox(height: 20),
                            inputForm(false),
                          ],
                        ),
                        Visibility(
                            visible: isLoading,
                            child: CircularProgressIndicator()
                        )
                      ],
                    )
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget MobileView(){
    return SafeArea(
        child: Scaffold(
          backgroundColor: CustomeColors.bg_color5_1,
          appBar: AppBar(
            backgroundColor: CustomeColors.bg_color5,
            title: Text(StaticData.allData[recIndex].Name,style: TextStyle(color: CustomeColors.white),),
            leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){ Navigator.pop(context); },),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Center(
                child: Container(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 10),
                            inputForm(true),
                          ],
                        ),
                        Visibility(
                            visible: isLoading,
                            child: CircularProgressIndicator()
                        )
                      ],
                    )
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget inputForm(bool _isMobileView){
    double width = _isMobileView?MediaQuery.of(context).size.width * 0.85:MediaQuery.of(context).size.width * 0.5;
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 30),
            CustomEditText1(
                hint: "Protein Name",
                onSaved: (value){
                  data["Name"] = value!;
                },
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return 'Enter protein name';
                    }
                    return null;
                  }
                },
                width: width,
              controller: nameController,
            ),
            SizedBox(height: 10),
            CustomEditText1(
                hint: "UniProt ID",
                validator: (value) {
                  if(value != null){
                    if (value.isEmpty) {
                      return 'Enter UniProt ID';
                    }
                    return null;
                  }
                },
                onSaved: (value){
                  data["UniProtID"] = value!;
                },
                width: width, controller: idController,
            ),
            SizedBox(height: 10),
            CustomEditText1(
                hint: "Organism",
                validator: (value) {
                  if(value != null){
                    if (value.isEmpty) {
                      return 'Enter Organism';
                    }return null;
                  }
                },
                onSaved: (value){
                  data["Organism"] = value!;
                },
                width: width, controller: orgController,
            ),
            SizedBox(height: 10),
            CustomEditText1(
                hint: "Type",
                validator: (value) {
                  if(value != null){
                    if (value.isEmpty) {
                      return 'Enter Type';
                    }return null;
                  }
                },
                onSaved: (value){
                  data["Type"] = value!;
                },
                width: width,
                controller: typeController,
            ),
            SizedBox(height: 10),
            CustomEditText1(
                hint: "Mass",
                validator: (value) {
                  if(value != null){
                    if (value.isEmpty) {
                      return 'Enter Mass';
                    }return null;
                  }
                },
                onSaved: (value){
                  data["Mass"] = value!;
                },
                width: width,
              controller: massController,
            ),
            SizedBox(height: 10),
            CustomEditText1(
                hint: "Length",
                validator: (value) {
                  if(value != null){
                    if (value.isEmpty) {
                      return 'Enter Length';
                    }return null;
                  }
                },
                onSaved: (value){
                  data["Length"] = value!;
                },
                width: width,
              controller: lengthController,
            ),
            SizedBox(height: 10),
            CustomEditText1(
                hint: "Function",
                validator: (value) {
                  if(value != null){
                    if (value.isEmpty) {
                      return 'Enter Function';
                    }return null;
                  }
                },
                onSaved: (value){
                  data["Function"] = value!;
                },
                width: width,
              controller: functionController,
            ),
            SizedBox(height: 10),


            //add validity true false ---------------------------------------------------------------------------------------------

            radioGroup(width),
            SizedBox(height: 10),

            CustomEditText1(
                hint: "Score",
                validator: (value) {

                },
                onSaved: (value){
                  data["Score"] = value!;
                },
                width: width,
              controller: scoreController,
            ),
            SizedBox(height: 10),
            CustomEditText1(
                hint: "X-Axis",
                validator: (value) {

                },
                onSaved: (value){
                  data["XAxis"] = value!;
                },
                width: width,
              controller: xController,
            ),
            SizedBox(height: 10),
            CustomEditText1(
                hint: "Y-Axis",
                validator: (value) {

                },
                onSaved: (value){
                  data["YAxis"] = value!;
                },
                width: width,
              controller: yController,
            ),
            SizedBox(height: 10),
            CustomEditText1(
                hint: "Z-Axis",
                validator: (value) {

                },
                onSaved: (value){
                  data["ZAxis"] = value!;
                },
                width: width,
              controller: zController,
            ),
            SizedBox(height: 10),
            CustomEditText1(
                hint: "Residues",
                validator: (value) {

                },
                onSaved: (value){
                  data["Residues"] = value!;
                },
                width: width,
              controller: resController,
            ),
            SizedBox(height: 20),
            chooseFileWidget(width: width,name: "PDB",onPressed: choosePDB,fileName: fileName1),
            SizedBox(height: 10),
            chooseFileWidget(width: width,name: "PDF",onPressed: choosePDF,fileName: fileName2),
            SizedBox(height: 10),
            SizedBox(height: 30),
            ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 60,vertical: 20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )
                  )
              ),
              onPressed: (){
                updateData();
              },
              child: Text("Update"),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget radioGroup(double width){
    return Container(
        padding: EdgeInsets.all(10),
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black12
        ),
        child: Column(
          children: [
            Text("Validity"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<booldata>(
                      fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
                      focusColor: MaterialStateColor.resolveWith((states) => Colors.green),
                      value: booldata.yes,
                      groupValue: _booldata,
                      onChanged: (value) {
                        setState(() {
                          _booldata = value!;
                          validation = "yes";
                        });
                      },
                    ),
                    Text('Yes'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<booldata>(
                      fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
                      focusColor: MaterialStateColor.resolveWith((states) => Colors.green),
                      value: booldata.no,
                      groupValue: _booldata,
                      onChanged: (value) {
                        setState(() {
                          _booldata = value!;
                          validation = "no";
                        });
                      },
                    ),
                    Text('No'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<booldata>(
                      fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
                      focusColor: MaterialStateColor.resolveWith((states) => Colors.green),
                      value: booldata.none,
                      groupValue: _booldata,
                      onChanged: (value) {
                        setState(() {
                          _booldata = value!;
                          validation = "none";
                        });
                      },
                    ),
                    Text('None'),
                  ],
                ),
              ],
            ),
          ],
        )
    );
  }

  Widget chooseFileWidget({required double width, required String name, required String fileName, required VoidCallback onPressed}){
    return Container(
      width: width,
      child: Row(
        children: [
          Text("$name: "),
          SizedBox(width: 30),
          ElevatedButton(
              onPressed: onPressed,
              child: Text("Choose File")
          ),
          SizedBox(width: 10),
          Text(fileName)
        ],
      ),
    );
  }
}
