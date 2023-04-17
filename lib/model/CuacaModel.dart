class CuacaModel {
  String? jamCuaca;
  String? kodeCuaca;
  String? cuaca;
  String? humidity;
  String? tempC;
  String? tempF;

  CuacaModel(
      {this.jamCuaca,
      this.kodeCuaca,
      this.cuaca,
      this.humidity,
      this.tempC,
      this.tempF});

  CuacaModel.fromJson(Map<String, dynamic> json) {
    jamCuaca = json['jamCuaca'];
    kodeCuaca = json['kodeCuaca'];
    cuaca = json['cuaca'];
    humidity = json['humidity'];
    tempC = json['tempC'];
    tempF = json['tempF'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jamCuaca'] = this.jamCuaca;
    data['kodeCuaca'] = this.kodeCuaca;
    data['cuaca'] = this.cuaca;
    data['humidity'] = this.humidity;
    data['tempC'] = this.tempC;
    data['tempF'] = this.tempF;
    return data;
  }
}
