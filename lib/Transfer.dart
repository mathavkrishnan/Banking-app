class Transfer {
  final String sender;
  final String receiver;
  final int amount;

  const Transfer({
    required this.sender,
    required this.receiver,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'receiver':receiver,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return 'Transfer{sender: $sender, receiver: $receiver,amount:$amount}';
  }
}