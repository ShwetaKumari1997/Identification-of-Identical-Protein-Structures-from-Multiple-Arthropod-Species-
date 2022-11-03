import 'package:flutter/material.dart';
import 'package:protein_database/services/static_data.dart';
import 'package:protein_database/utils/colors.dart';

class MainHeader extends StatefulWidget {
  final VoidCallback adminOnclicked, logoutClicked;
  final String header;
  const MainHeader({Key? key, required this.adminOnclicked, required this.logoutClicked, required this.header}) : super(key: key);

  @override
  State<MainHeader> createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {
  @override
  Widget build(BuildContext context) {
    print("data read");
    return Container(
      color: CustomeColors.primaryColor,
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(widget.header,style: TextStyle(
              color: CustomeColors.white,fontSize: 25
            ),),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: StaticData.userData.isAdmin,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30,vertical: 20)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                        )
                    ),
                    onPressed: widget.adminOnclicked,
                    child: Text("Admin"),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: widget.logoutClicked,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomeColors.white,width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("LOGOUT",style: TextStyle(fontSize: 14,color: CustomeColors.white),),
                        SizedBox(width: 5),
                        Icon(Icons.logout_outlined,color: CustomeColors.white,size: 14,),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          )
        ],
      )
    );
  }
}
