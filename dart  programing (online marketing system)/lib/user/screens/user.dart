import 'dart:io';

import '../handling errors/user handling.dart';
num totalPrice = 0;
class Inventory {
  List<int> amount;
  Inventory(this.amount);
}
Inventory inventory = Inventory([7, 8, 4, 5, 6, 3, 4]);
List<num> cardNumber = [];
dynamic securityKey = 12345;
List<String> products = [
  "laptop",
  "tablets",
  'cpu   ',
  "keys",
  "mouse",
  "phone",
  "camera"
];
List<num> prices = [12000, 5000, 500.00, 80.00, 20.00, 1000, 699.0];
(num, num, num) UserScreen() {
  print("product \t | \t price \t\t | \t avail");
  print("***************************************\n");
  for (int i = 0; i < prices.length; i++) {
    print(
        "${products[i]}    \t | \t${prices[i]}\t\t | \t${inventory.amount[i]}\n");
  }

  var result = userHandling(products, prices, inventory);
  totalPrice += result.$1;
  print("Current total price: $totalPrice\n");
  UserPayment();
  for (int i = 0; i < 7; i++) {
    print("\n");
  }
  return result;
}