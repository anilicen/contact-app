class Contact {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? profileImageUrl;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileImageUrl,
  });

  Contact copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
  }) =>
      Contact(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      );

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        profileImageUrl: json['profileImageUrl'],
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'profileImageUrl': profileImageUrl,
      };
}
