class LoginResponse {
  String? iv;
  String? key;
  String? token;
  bool? twoFactorAuthentication;

  LoginResponse({this.iv, this.key, this.token, this.twoFactorAuthentication});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      iv: json['iv'],
      key: json['key'],
      token: json['token'],
      twoFactorAuthentication: json['twoFactorAuthentication'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iv'] = this.iv;
    data['key'] = this.key;
    data['token'] = this.token;
    data['twoFactorAuthentication'] = this.twoFactorAuthentication;
    return data;
  }
}
