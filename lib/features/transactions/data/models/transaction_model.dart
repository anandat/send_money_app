class TransactionModel {
  final int id;
  final String name;
  final String email;
  final String avatar;

  TransactionModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      name: '${json['first_name']} ${json['last_name']}',
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}
