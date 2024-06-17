class CardModel {
  final String name;
  final String liveDate;
  final String address;
  final String status;
  final String type;
  final int size;
  final String imageUrl;

  CardModel({
    required this.name,
    required this.liveDate,
    required this.address,
    required this.status,
    required this.type,
    required this.size,
    required this.imageUrl,
  });

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      name: map['name'] as String? ?? 'unknown',
      liveDate: map['live_date'] as String? ?? 'unknown',
      address: map['address'] as String? ?? 'unknown',
      status: map['status'] as String? ?? 'unknown',
      type: map['type'] as String? ?? 'unknown',
      size: map['size'] as int? ?? 0,
      imageUrl: map['image']  as String? ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxdRuJUbPqVl4sn1M5J58ZdG8jDbJw-JEXxg&s',
    );
  }

  String get content {
    return  'Name: $name\n'
            'Live Date: $liveDate\n'
            'Address: $address\n'
            'Status: $status\n'
            'Type: $type\n'
            'Size: $size';
  }
}

