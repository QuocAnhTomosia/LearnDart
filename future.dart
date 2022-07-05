// future là hoạt động bất đồng bộ
// có 2 trang thái là uncomplete và complete

String createOrderMessage() {
  var order = fetchUserOrder();
  return 'Your order is: $order';
}

Future<String> fetchUserOrder() =>
    // Imagine that this function is more complex and slow.
    Future.delayed(
      const Duration(seconds: 2),
      () => 'Large Latte',
    );

Future<void> fetchUserOrderWithDelay() {
  // Imagine that this function is fetching user info from another service or database.
  return Future.delayed(const Duration(seconds: 2), () => print('Large Latte'));
}

Future<void> fetchUserOrderWithError() {
// Imagine that this function is fetching user info but encounters a bug
  return Future.delayed(const Duration(seconds: 2),
      () => throw Exception('Logout failed: user ID is invalid'));
}



void main() {

  //ví dụ 1 chạy khi chưa có async và await
  // sẽ in ra 1 instance thay vì order như mong muốn
  // do order đã có instance kia rồi nhưng fetch chưa chạy xong
  print(createOrderMessage());

  //chạy print trc khi hàm fetchWithDelay 
  // hoàn thành do bị delay

  fetchUserOrderWithDelay();
  print('Fetching user order...');

 // in ra exceptiom
  fetchUserOrderWithError();
  print('Fetching user order...');
}