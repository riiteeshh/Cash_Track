class TranscationModel {
  String name;
  String description;
  String type;
  num amount;
  DateTime dateTime;

  TranscationModel({
    required this.name,
    required this.description,
    required this.type,
    required this.amount,
    required this.dateTime,
  });
}
