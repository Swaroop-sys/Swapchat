import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String fullname;
  final String email;
  final String password;
  final String phonenumber;
  final bool isOnline;
  final Timestamp lastseen;
  final Timestamp createdat;
  final String? fcmtoekn;
  final List<String> blockedusers;

  UserModel({
    required this.uid,
    required this.username,
    required this.fullname,
    required this.email,
    required this.password,
    required this.phonenumber,
    this.isOnline = false,
    Timestamp? lastseen,
    Timestamp? createdat,
    this.fcmtoekn,
    this.blockedusers = const [],
  }) : lastseen = lastseen ?? Timestamp.now(),
       createdat = createdat ?? Timestamp.now();

  /// 🔁 copyWith method
  UserModel copyWith({
    String? uid,
    String? username,
    String? fullname,
    String? email,
    String? password,
    String? phonenumber,
    bool? isOnline,
    Timestamp? lastseen,
    Timestamp? createdat,
    String? fcmtoekn,
    List<String>? blockedusers,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
      phonenumber: phonenumber ?? this.phonenumber,
      isOnline: isOnline ?? this.isOnline,
      lastseen: lastseen ?? this.lastseen,
      createdat: createdat ?? this.createdat,
      fcmtoekn: fcmtoekn ?? this.fcmtoekn,
      blockedusers: blockedusers ?? this.blockedusers,
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      username: data['username'] ?? "",
      fullname: data['fullname'] ?? "",
      email: data['email'],
      password: data['password'],
      phonenumber: data['phonenumber'] ?? "",
      fcmtoekn: data['fcmtoekn'],
      lastseen: data['lastseen'] ?? Timestamp.now(),
      blockedusers: List<String>.from(data["blockedusers"]),
      createdat: data['createdat'] ?? Timestamp.now(),
      isOnline: data['isOnline'],
    );
  }
  Map<String, dynamic> tomap() {
    return {
      'username': username,
      'fullname': fullname,
      'email': email,
      'password': password,
      'phonenumber': phonenumber,
      'isOnline': isOnline,
      'lastseen': lastseen,
      'createdat': createdat,
      'fcmtoken': fcmtoekn,
      'blockedusers': blockedusers,
    };
  }
}
