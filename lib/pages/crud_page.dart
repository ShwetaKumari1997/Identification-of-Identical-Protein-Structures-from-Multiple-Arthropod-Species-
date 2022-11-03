import 'package:flutter/material.dart';
import 'package:protein_database/services/static_data.dart';

import '../utils/colors.dart';
import '../widgets/headers/header.dart';
import '../widgets/headers/main_header.dart';

class CrudPage extends StatefulWidget {
  const CrudPage({Key? key}) : super(key: key);

  @override
  State<CrudPage> createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {

  @override
  void initState(){
    super.initState();
    if(StaticData.userData.name == "not initialized"){
      Navigator.pushReplacementNamed(context, '/login');
    }else if(!StaticData.userData.isAdmin){
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
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

  Widget DesktopView() {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Header(backPressed: () { Navigator.pop(context); }, headerText: 'Admin Access', backgroundColor: CustomeColors.primaryColor,),
                  CRUDWidget()
                ],
              ),
            )
        )
    );
  }

  Widget MobileView() {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: CustomeColors.primaryColor,
              title: Text("Admin Access",style: TextStyle(color: CustomeColors.white),),
              leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){ Navigator.pop(context); },),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CRUDWidget()
                ],
              ),
            )
        )
    );
  }

  Widget CRUDWidget(){
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CustomeColors.bg_color3),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 60,vertical: 20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        side: BorderSide(width: 1,color: CustomeColors.grey2),
                        borderRadius: BorderRadius.circular(18.0),
                      )
                  )
              ),
              onPressed: (){
                Navigator.pushNamed(context, '/create');
              },
              child: Text("Create",style: TextStyle(color: CustomeColors.black),),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CustomeColors.bg_color4),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 60,vertical: 20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        side: BorderSide(width: 1,color: CustomeColors.grey2),
                        borderRadius: BorderRadius.circular(18.0),
                      )
                  )
              ),
              onPressed: (){
                Navigator.pushNamed(context, '/delete');
              },
              child: Text("Delete",style: TextStyle(color: CustomeColors.black),),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CustomeColors.bg_color5),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 60,vertical: 20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        side: BorderSide(width: 1,color: CustomeColors.grey2),
                        borderRadius: BorderRadius.circular(18.0),
                      )
                  )
              ),
              onPressed: (){
                Navigator.pushNamed(context, '/update');
              },
              child: Text("Update",style: TextStyle(color: CustomeColors.black),),
            ),
          ],
        ),
      ),
    );
  }

}
