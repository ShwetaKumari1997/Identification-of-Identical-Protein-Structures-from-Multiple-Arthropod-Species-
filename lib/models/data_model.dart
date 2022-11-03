import 'package:flutter/material.dart';

class DataModel {
  DataModel({
    required this.Name,
    required this.UniProtID,
    required this.Organism,
    required this.Type,
    required this.Mass,
    required this.Length,
    required this.Function,
    required this.Validity,
    required this.Score,
    required this.XAxis,
    required this.YAxis,
    required this.ZAxis,
    required this.Residues,
    required this.pdb,
    required this.pdf,
  });
  late final String Name;
  late final String UniProtID;
  late final String Organism;
  late final String Type;
  late final String Mass;
  late final String Length;
  late final String Function;
  late final String Validity;
  late final String Score;
  late final String XAxis;
  late final String YAxis;
  late final String ZAxis;
  late final String Residues;
  late final String pdb;
  late final String pdf;

  DataModel.fromJson(Map<String, dynamic> json){
    Name = json['Name'];
    print("1");
    UniProtID = json['UniProtID'];
    print("2");
    Organism = json['Organism'];
    print("3");
    Type = json['Type'];
    print("4");
    Mass = json['Mass'];
    print("5");
    Length = json['Length'];
    print("6");
    Function = json['Function'];
    print("7");
    Validity = json['Validity'];
    print("8");
    Score = json['Score'];
    print("9");
    XAxis = json['XAxis'];
    print("10");
    YAxis = json['YAxis'];
    print("11");
    ZAxis = json['ZAxis'];
    print("12");
    Residues = json['Residues'];
    print("13");
    pdb = json['pdb'];
    print("14");
    pdf = json['pdf'];
    print("15");
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Name'] = Name;
    _data['UniProtID'] = UniProtID;
    _data['Organism'] = Organism;
    _data['Type'] = Type;
    _data['Mass'] = Mass;
    _data['Length'] = Length;
    _data['Function'] = Function;
    _data['Validity'] = Validity;
    _data['Score'] = Score;
    _data['X_Axis'] = XAxis;
    _data['Y_Axis'] = YAxis;
    _data['Z_Axis'] = ZAxis;
    _data['Residues'] = Residues;
    _data['pdb'] = pdb;
    _data['pdf'] = pdf;
    return _data;
  }
}

/*{
  "Name":"wadwad",
  "UniProtID":"adwadaw",
  "Organism":"dwadawd",
  "Type":"Dwadawd",
  "Mass":"45885",
  "Length":"343",
  "Function":"dawdawdawd",
  "Validity":true,
  "Score":"0.5454224",
  "X_Axis":"-0.2328837",
  "Y_Axis":"-0.424324",
  "Z_Axis":"-0.43434",
  "Residues":"_83_GLY; _84_VAL; _87_PHE; _167_ASP; _168_ASN; _302_TYR; _314_ILE; _318_TYR"
  "pdb":"dwadwad",
  "pdf":"Dwadawd"
}*/
