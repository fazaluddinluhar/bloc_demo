class UserData {
  final String token;
  final int id;
  final String tenantName;
  final String email;
  final String fcmToken;
  final int expirationTime;

  UserData({
    required this.token,
    required this.id,
    required this.tenantName,
    required this.email,
    required this.fcmToken,
    required this.expirationTime,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      token: json['token'] as String,
      id: json['Id'] as int,
      tenantName: json['TenantName'] as String,
      email: json['Email'] as String,
      fcmToken: json['FCMToken'] as String,
      expirationTime: json['ExpirationTime'] as int,
    );
  }
}
