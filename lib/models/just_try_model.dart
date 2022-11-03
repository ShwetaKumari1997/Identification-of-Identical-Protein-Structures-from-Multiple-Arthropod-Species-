class JustTry {
  JustTry({
    required this.Name,
    required this.UniProtID,
    required this.Organism,
    required this.Type,
    required this.Mass,
    required this.Length,
    required this.Function,
    required this.Validity,
    required this.SCORE,
    required this.XAxis,
    required this.YAxis,
    required this.ZAxis,
    required this.Residues,
  });
  late final String? Name;
  late final String? UniProtID;
  late final String? Organism;
  late final String? Type;
  late final String? Mass;
  late final String? Length;
  late final String? Function;
  late final String? Validity;
  late final double? SCORE;
  late final double? XAxis;
  late final double? YAxis;
  late final double? ZAxis;
  late final String? Residues;

  JustTry.fromJson(Map<String, dynamic> json){
    Name = json['Name'];
    UniProtID = json['UniProtID'];
    Organism = json['Organism'];
    Type = json['Type'];
    Mass = json['Mass'];
    Length = json['Length'];
    Function = json['Function'];
    Validity = json['Validity'];
    SCORE = json['SCORE'];
    XAxis = json['X_axis'];
    YAxis = json['Y-axis'];
    ZAxis = json['Z-axis'];
    Residues = json['Residues'];
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
    _data['SCORE'] = SCORE;
    _data['XAxis'] = XAxis;
    _data['YAxis'] = YAxis;
    _data['ZAxis'] = ZAxis;
    _data['Residues'] = Residues;
    return _data;
  }
}