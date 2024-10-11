class LoginRequest {
    String userName;
    String password;

    LoginRequest({
        required this.userName,
        required this.password,
    });

    factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        userName: json["userName"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "password": password,
    };
}
