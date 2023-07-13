class UserModel {
  final String name;
  final String uid;
  final String profilPic;
  final bool isOnline;
  final String phoneNumber;
  final List<dynamic> groupId;

  UserModel({
    required this.name,
    required this.uid,
    required this.profilPic,
    required this.isOnline,
    required this.phoneNumber,
    required this.groupId,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'uid': uid,
        'profilPic': profilPic,
        'isOnline': isOnline,
        'phoneNumber': phoneNumber,
        'groupId': groupId,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'],
        uid: map['uid'],
        profilPic: map['profilPic'],
        isOnline: map['isOnline'],
        phoneNumber: map['phoneNumber'],
        groupId: map['groupId']);
  }
}
