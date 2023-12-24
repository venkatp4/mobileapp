class AutoGenerateValue {
  String prefix;
  String suffix;

  AutoGenerateValue({required this.prefix, required this.suffix});

  factory AutoGenerateValue.fromJson(Map<String, dynamic> json) {
    return AutoGenerateValue(
      prefix: json['prefix'],
      suffix: json['suffix'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prefix'] = this.prefix;
    data['suffix'] = this.suffix;
    return data;
  }
}
