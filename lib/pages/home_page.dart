import 'package:flutter/material.dart';
import 'package:protein_database/models/data_model.dart';
import 'package:protein_database/widgets/headers/main_header.dart';

import '../services/api_services.dart';
import '../services/static_data.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ApiServices apiServices = ApiServices();
  List<DataModel> _localData = [];
  int list_length = 0;

  String valueChanged = "";

  bool _isLoading = true;

  @override
  void initState(){
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await apiServices.fetchAllData();
    await apiServices.getUserData();
    setState((){list_length = StaticData.allData.length;_isLoading = false;});
  }

  void searchResult(String value) {
    List<DataModel> data = [];
    print(value);
    StaticData.allData.forEach((element) {
      if(value != ""){
        if(element.Name.toUpperCase().contains(value.toUpperCase()) ||
            element.UniProtID.toUpperCase().contains(value.toUpperCase()) ||
            element.Organism.toUpperCase().contains(value.toUpperCase()) ||
            element.Mass.toUpperCase().contains(value.toUpperCase()) ||
            element.Length.toUpperCase().contains(value.toUpperCase()) ||
            element.Function.toUpperCase().contains(value.toUpperCase()) ||
            element.Score.toUpperCase().contains(value.toUpperCase()) ||
            element.XAxis.toUpperCase().contains(value.toUpperCase()) ||
            element.YAxis.toUpperCase().contains(value.toUpperCase()) ||
            element.ZAxis.toUpperCase().contains(value.toUpperCase()) ||
            element.Residues.toUpperCase().contains(value.toUpperCase())
        ){
          data.add(element);
        }
      }
    });
    setState((){_localData = data;});
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

  Widget MobileView(){
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: CustomeColors.primaryColor,
              title: Text("Unified Aegypti Protein Resource Database",style: TextStyle(color: CustomeColors.white),),
              actions: [
                SizedBox(width: 10),
                Visibility(visible: StaticData.userData.isAdmin,child: IconButton(onPressed: (){Navigator.pushNamed(context, "/crud_page");}, icon: Icon(Icons.admin_panel_settings_outlined))),
                SizedBox(width: 10),
                IconButton(onPressed: (){ShowDialogue();}, icon: Icon(Icons.logout_outlined)),
                SizedBox(width: 10),
              ],
            ),
            body: SingleChildScrollView(
              child: _isLoading?Container(child: Center(child: Container(height: 50,width: 50,child: CircularProgressIndicator(),),),):
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  ImageAndSearch(true),
                  SizedBox(height: 30),
                  viewAllData(true)
                ],
              ),
            )
        )
    );
  }



  void ShowDialogue(){
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("no"),
      onPressed: (){
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("yes"),
      onPressed:  () {
        print("logout yes pressed");
        apiServices.logoutUser();
        print("done logout");
        Navigator.pushReplacementNamed(context, '/login');
        print("closing popup");
        //Navigator.pop(context);
        print("done everything");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Are you sure you want to logout!"),
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

  Widget DesktopView(){
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: _isLoading?Container(child: Center(child: Container(height: 50,width: 50,child: CircularProgressIndicator(),),),):
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MainHeader(adminOnclicked: (){ Navigator.pushNamed(context, "/crud_page");}, logoutClicked: ShowDialogue, header: "Unified Aegypti Protein Resource Database"),
                SizedBox(height: 20),
                ImageAndSearch(false),
                SizedBox(height: 30),
                viewAllData(false)
              ],
            ),
          )
        )
    );
  }



  Widget ImageAndSearch(bool _isMobileView){
    return Container(
      width: _isMobileView?MediaQuery.of(context).size.width * 0.6:MediaQuery.of(context).size.width * 0.22,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/logo3.jpeg",width: _isMobileView?MediaQuery.of(context).size.width * 0.3:MediaQuery.of(context).size.width * 0.1,),
          SizedBox(height: 30),
          Container(
            width: _isMobileView?MediaQuery.of(context).size.width * 0.6:MediaQuery.of(context).size.width * 0.22,
            child: TextFormField(
              style: TextStyle(color: CustomeColors.black2,fontSize: 16),
              obscureText: false,
              onChanged: (value){
                if(value != valueChanged){
                  valueChanged = value;
                  print("value = $value  value changed = $valueChanged");
                  searchResult(value);
                }

              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                  suffixIcon: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.search),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget viewAllData(bool _isMobileview){
    return (_localData.length == 0)?Container():
    _isMobileview?SingleChildScrollView(
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
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
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
              Expanded(flex: 2,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[0],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[1],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[2],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[3],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[4],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[5],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 5,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[6],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[7],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[8],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[9],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[10],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[11],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 3,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[12],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[13],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
              Expanded(flex: 1,child: Container(color:CustomeColors.primaryColor,height:30,child: Center(child: Text(StaticData.headingData[14],maxLines: 10,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),))),
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
          itemCount: _localData.length,
          itemBuilder: (context,index){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(border: Border.all(width: 1,color: CustomeColors.black)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(flex: 2,child: Container(child: Text(_localData[index].Name,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(_localData[index].UniProtID,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(_localData[index].Organism,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(_localData[index].Type,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(_localData[index].Mass,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(_localData[index].Length,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 5,child: Container(child: Text(_localData[index].Function,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(_localData[index].Validity,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(_localData[index].Score,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(_localData[index].XAxis,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(_localData[index].YAxis,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 1,child: Container(child: Text(_localData[index].ZAxis,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
                  Expanded(flex: 3,child: Container(child: Text(_localData[index].Residues,maxLines: 20,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),)),
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
                      onPressed: (){ apiServices.downloadData(_localData[index].pdb);},
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
                      onPressed: (){ apiServices.downloadData(_localData[index].pdf); },
                      child: Text("PDF",style: TextStyle(fontSize: 12),),
                    ),)),
                ],
              ),
            );
          }
      ),
    );

  }

}


