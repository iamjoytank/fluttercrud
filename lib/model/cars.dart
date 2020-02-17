class Cars {
  String id;
  String carModel;
  String carColor;

  Cars({this.id, this.carModel, this.carColor});

  Cars.fromMap(Map snapshot,String id) :
        id = id ?? '',
        carModel = snapshot['carModel'] ?? '',
        carColor = snapshot['carColor'] ?? '';

  toJson() {
    return {
      "carModel": carModel,
      "carColor": carColor,
    };
  }
}