class UserData {
  final String uid;
  final String name;
  final String avatar;

  UserData({this.name, this.uid, this.avatar});

  factory UserData.fromMap(Map<dynamic, dynamic> data) {
    data = data ?? {};
    return UserData(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      avatar: data['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'name': this.name,
      'avatar': this.avatar,
    };
  }
}
