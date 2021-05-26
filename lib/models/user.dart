class UserData {
  final String uid;
  final String name;
  final String avatar;
  final String footSteps;

  UserData({this.name, this.uid, this.avatar, this.footSteps});

  factory UserData.fromMap(Map<dynamic, dynamic> data) {
    data = data ?? {};
    return UserData(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      avatar: data['avatar'] ?? '',
      footSteps: data['footSteps'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'name': this.name,
      'avatar': this.avatar,
      'footSteps': this.footSteps,
    };
  }
}
