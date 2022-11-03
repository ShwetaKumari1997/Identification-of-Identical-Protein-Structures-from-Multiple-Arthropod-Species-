import 'package:flutter/material.dart';

import '../../services/api_services.dart';
import '../../services/static_data.dart';
import '../../utils/colors.dart';
import '../../widgets/headers/header.dart';


class Update1 extends StatefulWidget {
  const Update1({Key? key}) : super(key: key);

  @override
  State<Update1> createState() => _Update1State();
}

class _Update1State extends State<Update1> {
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


  @override
  Widget build(BuildContext context) {
    return data();
  }

  Widget data(){
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
          Header(backPressed: () { Navigator.pop(context); }, headerText: 'Update Data', backgroundColor: CustomeColors.bg_color5,),
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
              Expanded(flex: 2,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[0],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[1],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[2],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[3],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[4],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[5],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 5,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[6],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[7],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[8],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[9],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[10],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[11],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 3,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[12],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[13],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text(StaticData.headingData[14],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.bg_color5,height:30,child: Center(child: Text("Update",maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
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
                  Expanded(flex: 1,child: Container(child: IconButton( icon: Icon(Icons.edit_outlined,color: CustomeColors.secondaryColor,), onPressed: () {
                    Navigator.pushNamed(context, '/update_edit',arguments: index);
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
            backgroundColor: CustomeColors.bg_color5_1,
            appBar: AppBar(
              backgroundColor: CustomeColors.primaryColor,
              title: Text("Update Data",style: TextStyle(color: CustomeColors.white),),
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
