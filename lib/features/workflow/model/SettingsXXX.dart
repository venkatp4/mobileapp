class SettingsXXX {
  String? description;
  String? title;

  SettingsXXX({this.description, this.title});

  factory SettingsXXX.fromJson(Map<String, dynamic> json) {
    return SettingsXXX(
      description: json['description'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['title'] = this.title;
    return data;
  }
}
