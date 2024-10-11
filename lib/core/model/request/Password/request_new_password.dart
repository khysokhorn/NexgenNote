class RequestNewPassword {
  final String? currentPassword;
  final String? newPassword;

  RequestNewPassword({
    this.currentPassword,
    this.newPassword,
  });

  factory RequestNewPassword.fromJson(Map<String, dynamic> json) => RequestNewPassword(
        currentPassword: json["currentPassword"],
        newPassword: json["newPassword"],
      );

  Map<String, dynamic> toJson() => {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
      };
}
