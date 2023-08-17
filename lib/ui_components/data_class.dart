import 'package:untitled10/home_page.dart';


class chatUser{
  final String id;
  final String name;
  final String email;

//<editor-fold desc="Data Methods">

  const chatUser({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is chatUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;

  @override
  String toString() {
    return 'chatUser{' +
        ' id: $id,' +
        ' name: $name,' +
        ' email: $email,' +
        '}';
  }

  chatUser copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return chatUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
    };
  }

  factory chatUser.fromMap(Map<String, dynamic> map) {
    return chatUser(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

//</editor-fold>
}