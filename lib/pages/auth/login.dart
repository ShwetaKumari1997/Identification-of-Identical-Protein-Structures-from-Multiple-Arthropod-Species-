import 'package:flutter/material.dart';
import 'package:protein_database/services/api_services.dart';
import 'package:protein_database/utils/colors.dart';
import 'package:protein_database/widgets/edit_text.dart';
import 'package:protein_database/widgets/edit_text1.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscure = false;

  ApiServices apiServices = ApiServices();
  late String email,password;

  void _loginUser() async {
    setState((){_isLoading = true;});
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      String returnData = await apiServices.loginUser(email, password);
      if(returnData == "success"){
        errorDisplay("login successful");
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
          backgroundColor: CustomeColors.bg_color1,
          body: Center(
            child: _loginDesktopData()
            /*ErrorPage()*/
          )
        )
    );
  }

  Widget ErrorPage(){
    return Container(
      child: Text("404 Error page doesn't exists", style: TextStyle(color: CustomeColors.primaryColor,fontSize: 25),),
    );
  }

  Widget _loginDesktopData(){
    return Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Center(
          child: _isLoading?Container(height: 50,width: 50,child: CircularProgressIndicator(),):
          Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: CustomeColors.secondaryColor)),
                  SizedBox(height: 30),
                  CustomEditText(
                      hint: "Email",
                      validator: (value){
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Enter Email';
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      style: TextStyle(color: CustomeColors.black2,fontSize: 16),
                      obscureText: !_obscure,
                      validator: (value){
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Email should not be empty';
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
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: CustomeColors.black),
                            gapPadding: 10,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: CustomeColors.black),
                            gapPadding: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: CustomeColors.black),
                            gapPadding: 10,
                          ),
                          isDense: true,
                          labelText: "Password",
                          hintText: "Password",
                          hintStyle: TextStyle(color: CustomeColors.black,fontSize: 14),
                          labelStyle: TextStyle(color: CustomeColors.black,fontSize: 14),
                          contentPadding: EdgeInsets.symmetric(horizontal: 18,vertical: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _obscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: CustomeColors.black,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                          )

                      ),
                    ),
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
                        onPressed: (){ _loginUser(); },
                        child: Text("Login"),
                      ),
                    ],),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: Theme.of(context).textTheme.bodySmall),
                      SizedBox(width: 10),
                      GestureDetector(onTap: (){ Navigator.pushReplacementNamed(context, '/signup');},child: Text("Sign Up",style: TextStyle(color: CustomeColors.secondaryColor))),
                    ],
                  )
                ]
            ),
          ),
        )
    );
  }

  Widget _loginMobileData(){
    return Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Center(
          child: _isLoading?Container(height: 50,width: 50,child: CircularProgressIndicator(),):
          Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: CustomeColors.secondaryColor)),
                  SizedBox(height: 30),
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
                      width: MediaQuery.of(context).size.width * 0.85
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: TextFormField(
                      style: TextStyle(color: CustomeColors.black2,fontSize: 16),
                      obscureText: !_obscure,
                      validator: (value){
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Email should not be empty';
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
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: CustomeColors.black),
                            gapPadding: 10,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: CustomeColors.black),
                            gapPadding: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: CustomeColors.black),
                            gapPadding: 10,
                          ),
                          isDense: true,
                          labelText: "Password",
                          hintText: "Password",
                          hintStyle: TextStyle(color: CustomeColors.black,fontSize: 14),
                          labelStyle: TextStyle(color: CustomeColors.black,fontSize: 14),
                          contentPadding: EdgeInsets.symmetric(horizontal: 18,vertical: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _obscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: CustomeColors.black,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                          )

                      ),
                    ),
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
                        onPressed: (){ _loginUser(); },
                        child: Text("Login"),
                      ),
                    ],),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: Theme.of(context).textTheme.bodySmall),
                      SizedBox(width: 10),
                      GestureDetector(onTap: (){ Navigator.pushReplacementNamed(context, '/signup');},child: Text("Sign Up",style: TextStyle(color: CustomeColors.secondaryColor))),
                    ],
                  )
                ]
            ),
          ),
        )
    );
  }

  Widget MobileView(){
    return SafeArea(
        child: Scaffold(
            backgroundColor: CustomeColors.bg_color1,
            body: Center(
                child: _loginMobileData()
                /*ErrorPage()*/
            )
        )
    );
  }

  bool validateEmail(String email){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

}
