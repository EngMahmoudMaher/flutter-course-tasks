import 'dart:io';

void main() {
  dashboardSelection();
}

//===============================================================================================
void dashboardSelection() {
  print(" \t \t ..........welcome to our online market......... \t \t ");
  print(" 1 - user screen ");
  print(" 2 - admin screen ");
  print(" 3 - exit order \n");
  stdout.write("enter selection : ");
  int selection = int.parse(stdin.readLineSync()!);
  switch (selection) {
    case 1:
      UserScreen();
      break;
    case 2:
      adminPanel();
      break;
    case 3:
      exit(0); // Exit the program
  }
}

//===============================================================================================
class Inventory {
  List<int> amount;
  Inventory(this.amount);
}

//===============================================================================================
num totalPrice = 0;
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

//===============================================================================================
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

//===============================================================================================
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

//===============================================================================================
void UserPayment() {
  print(" please select your payment method ........\n");
  print(" 1 - cash ");
  print(" 2 - card ");
  stdout.write("enter selection : ");
  int selection = int.parse(stdin.readLineSync()!);
  switch (selection) {
    case 1:
      {
        transcript();
      }
      break;
    case 2:
      {
        print(" we don’t save your pin .....\n");
        stdout.write(" enter card number : ");
        num cardNumber1 = int.parse(stdin.readLineSync()!);
        cardNumber.add(cardNumber1);
        stdout.write(" entercard pin : ");
        int.parse(stdin.readLineSync()!); // Read and discard the pin
        transcript();
      }
  }
}

//===============================================================================================
void transcript() {
  print(" you will pay : $totalPrice");
  print(" thanks for using our online market ");
  stdout.write(" need any other product (y/n)? : ");
  String selection = stdin.readLineSync()!;
  if (selection == 'y')
    UserScreen();
  else {
    print(" thanks for using our online market.......... ");
    dashboardSelection();
  }
}

//===============================================================================================
void adminPanel() {
  checkSecurity();
  adminSelection();
}

//===============================================================================================
void checkSecurity() {
  stdout.write(" enter password : ");
  num key = int.parse(stdin.readLineSync()!);
  if (key == securityKey) {
    print("welcome back Eng/ Mahmoud....... ");
  } else {
    print("........wrong password....... ");
    while (key != securityKey) {
      stdout.write(" enter password : ");
      num key = int.parse(stdin.readLineSync()!);
      if (key == securityKey) {
        print("welcome back Eng/ Mahmoud....... ");
        adminSelection();
        return; // Exit the function after successful login
      } else
        print("........wrong password....... ");
    }
    print("........Access Denied Invalid Permission.....");
  }
}

//===============================================================================================
void adminSelection() {
  print(" 1 - total cash ");
  print(" 2 - card number ");
  print(" 3 - add product ");
  print(" 4 - remove product ");
  print(" 5- change security key ");
  print(" 6- main menu ");
  stdout.write("enter selection : ");
  int selection = int.parse(stdin.readLineSync()!);
  switch (selection) {
    case 1:
      {
        stdout.write("total cash :$totalPrice \n\n\n\n");
        adminSelection();
      }
      break;
    case 2:
      {
        stdout.write("card number :$cardNumber \n\n\n\n");
        adminSelection();
      }
      break;
    case 3:
      {
        addNewProduct();
        adminSelection();
      }
      break;
    case 4:
      {
        removeProduct();
        dashboardSelection();
      }
      break;
    case 5 :
      pass_change();
    case 6:
      dashboardSelection();
      break;
    // Add case 4 for changing security key if needed
  }
}

//===============================================================================================
void addNewProduct() {
  stdout.write("Enter the name of the new product: ");
  String newProductName = stdin.readLineSync()!;
  products.add(newProductName);

  stdout.write("Enter the price of the new product: ");
  num newProductPrice = num.parse(stdin.readLineSync()!);
  prices.add(newProductPrice);

  stdout.write("Enter the available amount of the new product: ");
  int newProductAmount = int.parse(stdin.readLineSync()!);
  inventory.amount.add(newProductAmount);

  print("New product added successfully!");
}

//==============================================================================
void removeProduct() {
  stdout.write("Enter the serial of the product: ");
  int indexToRemove = int.parse(stdin.readLineSync()!);
  if (indexToRemove != -1) {
    products.removeAt(indexToRemove);
    prices.removeAt(indexToRemove);
    inventory.amount.removeAt(indexToRemove);
    print("Product ${products[indexToRemove]}removed successfully.");
  }
}
//==============================================================================
void pass_change()
{stdout.write("Enter the new password: ");
num pass1 = int.parse(stdin.readLineSync()!);
stdout.write("Renter the new password: ");
num pass = int.parse(stdin.readLineSync()!);
if(pass1!=pass){
  print("........operation Denied Invalid operation .....");
pass_change();}
  else
    {
securityKey=pass;
  adminPanel();
    }
}
