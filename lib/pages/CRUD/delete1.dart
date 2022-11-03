
import 'package:flutter/material.dart';
import 'package:protein_database/services/api_services.dart';
import 'package:protein_database/services/static_data.dart';
import 'package:protein_database/utils/colors.dart';

import '../../widgets/headers/header.dart';
import '../../widgets/headers/main_header.dart';

class Delete1 extends StatefulWidget {
  const Delete1({Key? key}) : super(key: key);

  @override
  State<Delete1> createState() => _Delete1State();
}

class _Delete1State extends State<Delete1> {

  ApiServices apiServices = ApiServices();

  bool _isLoading = false;

  @override
  void initState(){
    super.initState();
    if(StaticData.userData.name == "not initialized"){
      Navigator.pushReplacementNamed(context, '/login');
    }else if(!StaticData.userData.isAdmin){
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void fetchData() async {
    await apiServices.fetchAllData();
    setState((){_isLoading=false;});
  }

  void deleteData(int index) async {
    setState((){_isLoading=true;});
    await apiServices.deleteData(index);
    fetchData();
  }

  void ShowDialogue(BuildContext context, int index,String heading){
      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed: (){
          Navigator.pop(context);
        },
      );
      Widget continueButton = TextButton(
        child: Text("Continue"),
        onPressed:  () {
          deleteData(index);
          Navigator.pop(context);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("AlertDialog"),
        content: Text(heading),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
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

  Widget DesktopView(){
    return SafeArea(
        child: Scaffold(
          backgroundColor: CustomeColors.bg_color4_1,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Center(
                  child: Stack(
                    children: [
                      viewAllData(false),
                      Visibility(
                          visible: _isLoading,
                          child:Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: CircularProgressIndicator(),
                            )
                          )
                      )
                    ],
                  )
              ),
            ),
          )
        )
    );
  }

  Widget viewAllData(bool _isMobileView){
    return _isMobileView?SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              heading(true),
              dataSet(true)
            ],
          )
      ),
    ):
    Container(
      child: Column(
        children: [
          Header(backPressed: () { Navigator.pop(context); }, headerText: 'Delete Data', backgroundColor: CustomeColors.bg_color4,),
          SizedBox(height: 20),
          heading(false),
          dataSet(false)
        ],
      ),
    );
  }

  Widget heading(bool _isMobileView){
    return Container(
      width: _isMobileView? 1500: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(border: Border.all(width: 1,color: CustomeColors.black)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(flex: 2,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[0],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[1],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[2],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[3],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[4],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[5],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 5,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[6],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[7],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[8],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[9],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[10],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[11],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 3,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[12],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[13],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[14],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
            Expanded(flex: 1,child: Container(color:CustomeColors.bg_color4,height:30,child: Center(child: Text(StaticData.headingData[15],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
          ],
        ),
      )
    );
  }

  Widget dataSet(bool _isMobileView){
    return Container(
      width: _isMobileView? 1500: MediaQuery.of(context).size.width,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: StaticData.allData.length,
          itemBuilder: (context,index){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(border: Border.all(width: 1,color: CustomeColors.black)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(flex: 2,child: Container(child: Text(StaticData.allData[index].Name,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(StaticData.allData[index].UniProtID,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(StaticData.allData[index].Organism,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(StaticData.allData[index].Type,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(StaticData.allData[index].Mass,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(StaticData.allData[index].Length,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 5,child: Container(child: Text(StaticData.allData[index].Function,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(StaticData.allData[index].Validity,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(StaticData.allData[index].Score,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(StaticData.allData[index].XAxis,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(StaticData.allData[index].YAxis,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(StaticData.allData[index].ZAxis,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 3,child: Container(child: Text(StaticData.allData[index].Residues,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 2,vertical: 2)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                        )
                    ),
                    onPressed: (){apiServices.downloadData(StaticData.allData[index].pdb);},
                    child: Text("PDB",style: TextStyle(fontSize: 12),),
                  ),)),
                  Expanded(flex: 1,child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 2,vertical: 2)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                        )
                    ),
                    onPressed: (){apiServices.downloadData(StaticData.allData[index].pdf);},
                    child: Text("PDF",style: TextStyle(fontSize: 12),),
                  ),)),
                  Expanded(flex: 1,child: Container(child: IconButton( icon: Icon(Icons.delete_outline,color: CustomeColors.secondaryColor,), onPressed: () {
                    ShowDialogue(context,index,"Are you sure you want to delete " + StaticData.allData[index].Name);
                  },))),
                ],
              ),
            );
          }
      ),
    );

  }

  Widget MobileView(){
    return SafeArea(
        child: Scaffold(
            backgroundColor: CustomeColors.bg_color4_1,
            appBar: AppBar(
              backgroundColor: CustomeColors.bg_color4,
              title: Text("Delete Data",style: TextStyle(color: CustomeColors.white),),
              leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){ Navigator.pop(context); },),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Center(
                    child: Stack(
                      children: [
                        viewAllData(true),
                        Visibility(
                            visible: _isLoading,
                            child:Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                )
                            )
                        )
                      ],
                    )
                ),
              ),
            )
        )
    );
  }


}
