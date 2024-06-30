import 'dart:io' show stdin, stdout;
import '../screens/dashboard.dart';
import '../screens/user.dart';

(num, num, num) userHandling(
    List<String> products, List<num> prices, Inventory inventory) {
  stdout.write("product (enter -1 to exit): \n");
  int productSelection = int.parse(stdin.readLineSync()!);
  if (productSelection == -1) dashboardSelection(); // Exit condition

  // Check if product selection is valid
  if (productSelection < 0 || productSelection >= products.length) {
    print("Invalid product selection.\n\n");
    UserScreen();
    return (0, 0, 0);
  }

  stdout.write("amount: ");
  int amountSelection = int.parse(stdin.readLineSync()!);

  // Check if enough stock is available
  if (amountSelection <= inventory.amount[productSelection]) {
    num price = prices[productSelection] * amountSelection;
    inventory.amount[productSelection] -= amountSelection;
    print("Price of this item: $price");
    return (price, productSelection, amountSelection);
  } else {
    print("Not enough stock available.");
    return (0, 0, 0);
  }
}