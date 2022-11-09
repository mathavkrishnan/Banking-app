class Users {
  final int id;
  final String name;
  final String email;
  final int amount;
  final String image;

  const Users({
    required this.id,
    required this.name,
    required this.email,
    required this.amount,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email':email,
      'amount': amount,
      'image':image
    };
  }

  @override
  String toString() {
    return 'user{id: $id, name: $name, email: $email,amount:$amount,image:$image}';
  }
}