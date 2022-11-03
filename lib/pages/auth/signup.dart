import 'package:flutter/material.dart';

import '../../services/api_services.dart';
import '../../utils/colors.dart';
import '../../widgets/edit_text.dart';
import '../../widgets/edit_text1.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  ApiServices apiServices = ApiServices();
  late String name,email,password;

  TextEditingController passwordController = TextEditingController();

  void _signINUser() async {
    setState((){_isLoading = true;});
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      String returnData = await apiServices.signupUser(email, password, name);
      if(returnData == "success"){
        errorDisplay("Sign-Up successful");
        Navigator.pushReplacementNamed(context, '/home');
      }else{
        errorDisplay(returnData);
      }
    }
    setState((){_isLoading = false;});
  }

  void errorDisplay(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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
            backgroundColor: CustomeColors.bg_color6,
            body: _signupDesktopData()
        )
    );
  }

  Widget _signupDesktopData(){
    return Center(
      child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Center(
            child: SingleChildScrollView(
              child: Center(
                child: _isLoading?Container(height: 50,width: 50,child: CircularProgressIndicator(),):
                Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("SIGN UP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: CustomeColors.primaryColor),),
                        SizedBox(height: 30),
                        CustomEditText(
                            hint: "Name",
                            validator: (value){
                              if(value != null){
                                if (value.isEmpty) {
                                  return 'Enter Name';
                                }return null;
                              }
                            },
                            onSaved: (value){
                              if(value != null){
                                name = value;
                              }
                            },
                            width: MediaQuery.of(context).size.width * 0.45
                        ),
                        SizedBox(height: 10),
                        CustomEditText(
                            hint: "Email",
                            validator: (value){
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Enter Email ID';
                                }
                                else if(!validateEmail(value)){
                                  return 'Enter a Valide Email Id';
                                }
                                return null;
                              }
                            },
                            onSaved: (value){
                              if(value != null){
                                email = value;
                              }
                            },
                            width: MediaQuery.of(context).size.width * 0.45
                        ),
                        SizedBox(height: 10),
                        CustomEditText1(
                          hint: "Password",
                          validator: (value){
                            if (value != null) {
                              if (value.isEmpty) {
                                return 'Password should not be empty';
                              }else if(value.length < 7){
                                return 'Password should container more than 7 characters';
                              }
                              return null;
                            }
                          },
                          onSaved: (value){
                            if(value != null){
                              password = value;
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.45,
                          controller: passwordController,
                        ),
                        SizedBox(height: 10),
                        CustomEditText(
                          hint: "Confirm password",
                          validator: (value){
                            if (value != null) {
                              if (value.isEmpty) {
                                return 'Confirm password should not be empty';
                              }else if(value.length < 7){
                                return 'Password should container more than 7 characters';
                              }else if(value != passwordController.text.toString().trim()){
                                return "Password doesn't match";
                              }
                              return null;
                            }
                          },
                          onSaved: (value){
                            if(value != null){
                              password = value;
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.45,
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                _signINUser();
                              },
                              child: Text("Sign Up"),
                            ),
                          ],),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already exist account?",style: Theme.of(context).textTheme.bodySmall),
                            SizedBox(width: 10),
                            GestureDetector(onTap: (){Navigator.pushReplacementNamed(context, '/login');},child: Text("login",style: TextStyle(color: CustomeColors.primaryColor))),
                          ],
                        )
                      ]
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }

  Widget _signupMobileData(){
    return Center(
      child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: SingleChildScrollView(
              child: Center(
                child: _isLoading?Container(height: 50,width: 50,child: CircularProgressIndicator(),):
                Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("SIGN UP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: CustomeColors.primaryColor),),
                        SizedBox(height: 30),
                        CustomEditText(
                            hint: "Name",
                            validator: (value){
                              if(value != null){
                                if (value.isEmpty) {
                                  return 'Enter Name';
                                }return null;
                              }
                            },
                            onSaved: (value){
                              if(value != null){
                                name = value;
                              }
                            },
                            width: MediaQuery.of(context).size.width * 0.95
                        ),
                        SizedBox(height: 10),
                        CustomEditText(
                            hint: "Email",
                            validator: (value){
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Enter protein name';
                                }
                                else if(!validateEmail(value)){
                                  return 'Enter a Valide Email Id';
                                }
                                return null;
                              }
                            },
                            onSaved: (value){
                              if(value != null){
                                email = value;
                              }
                            },
                            width: MediaQuery.of(context).size.width * 0.95
                        ),
                        SizedBox(height: 10),
                        CustomEditText1(
                          hint: "Password",
                          validator: (value){
                            if (value != null) {
                              if (value.isEmpty) {
                                return 'Email should not be empty';
                              }else if(value.length < 7){
                                return 'Password should contain more than 7 characters';
                              }
                              return null;
                            }
                          },
                          onSaved: (value){
                            if(value != null){
                              password = value;
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.95,
                          controller: passwordController,
                        ),
                        SizedBox(height: 10),
                        CustomEditText(
                          hint: "Confirm password",
                          validator: (value){
                            if (value != null) {
                              if (value.isEmpty) {
                                return 'Email should not be empty';
                              }else if(value.length < 7){
                                return 'Password should contain more than 7 characters';
                              }else if(value != passwordController.text.toString().trim()){
                                return "Password doesn't match";
                              }
                              return null;
                            }
                          },
                          onSaved: (value){
                            if(value != null){
                              password = value;
                            }
                          },
                          width: MediaQuery.of(context).size.width * 0.95,
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                _signINUser();
                              },
                              child: Text("Sign Up"),
                            ),
                          ],),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already exist account?",style: Theme.of(context).textTheme.bodySmall),
                            SizedBox(width: 10),
                            GestureDetector(onTap: (){Navigator.pushReplacementNamed(context, '/login');},child: Text("login",style: TextStyle(color: CustomeColors.primaryColor))),
                          ],
                        )
                      ]
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }

  Widget MobileView(){
    return SafeArea(
        child: Scaffold(
            backgroundColor: CustomeColors.bg_color6,
            body: _signupMobileData()
        )
    );
  }

  bool validateEmail(String email){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

}
