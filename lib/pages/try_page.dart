import 'package:flutter/material.dart';
import 'package:protein_database/services/api_services.dart';

class TryPage extends StatefulWidget {
  const TryPage({Key? key}) : super(key: key);

  @override
  State<TryPage> createState() => _TryPageState();
}

class _TryPageState extends State<TryPage> {


  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () { apiServices.uploadTryData(); },
              child: Text("upload"),
            ),
          ),
        )
    );
  }
}
