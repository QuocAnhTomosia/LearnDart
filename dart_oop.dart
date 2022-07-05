// tao ra class Vehicle
// roi  tao class con la Car va Motorbike

class Vehicle {
  late int _horsePower;
  Vehicle(int horsePower) {
    this._horsePower = horsePower;
  }

  get power => _horsePower;
  String move() {
    return "xe dang di ";
  }
}

class Car extends Vehicle {
  String? _branch = "";
  String? _color = "";
  int? _minSpeed = 0;
  int? _maxSpeed = 0;
  Car(int minSpeed, int maxSpeed, String branch, String color, int horsePower) : super(0) {
    super._horsePower = horsePower;
    _minSpeed = minSpeed;
    _maxSpeed = maxSpeed;
    _color = color;
    _branch = branch;
  }

  get branch => _branch;
  get color => _color;
  get minSpeed => _minSpeed;
  get maxSpeed => _maxSpeed;

  @override
  String move() {
    return "xe dang di voi toc do" + power.toString();
  }
}

void main(List<String> args) {
  Car a = Car(10, 100, "toyota", "black",100);
  print(a.move());
}
