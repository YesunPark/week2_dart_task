import 'package:week2_dart_task/week2_dart_task.dart' as week2_dart_task;
import 'dart:io';

void main(List<String> arguments) {
  final mall = ShoppingMall();
  bool isRunning = true;

  while (isRunning) {
    print("""
    ------------------------------------------------------------------------------------------------------
    [1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료
    ------------------------------------------------------------------------------------------------------
    """);
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        mall.showProducts();
        break;
      case '2':
        mall.addToCart();
        break;
      case '3':
        mall.showTotal();
        break;
      case '4': // 필수 기능 4. 쇼핑몰 종료기능
        print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
        isRunning = false;
        return;
      default:
        print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
    }
  }
}

/*
 * 상품
 */
class Product {
  String name; // 상품 이름
  int price; // 상품 1개당 가격

  Product({required this.name, required this.price});
}

/*
 * 쇼핑몰 
 */
class ShoppingMall {
  List<Product> products = []; // 판매하는 상품 목록
  List<Product> cart = []; // 장바구니에 담긴 상품 목록
  int totalPrice = 0; // 장바구니에 담은 사움들의 총 가격

  ShoppingMall() {
    products = [
      Product(name: '셔츠', price: 45000),
      Product(name: '원피스', price: 30000),
      Product(name: '반팔티', price: 35000),
      Product(name: '반바지', price: 38000),
      Product(name: '양말', price: 5000),
    ];
  }

  // 필수 기능 1. 상품 목록 출력
  void showProducts() {
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  // 필수 기능 2. 상품을 장바구니에 담을 수 있는 기능
  void addToCart() {
    // 상품명 입력
    stdout.write('상품 이름을 입력해 주세요 !\n');
    String? inputProductName = stdin.readLineSync();
    // 숫자 입력
    stdout.write('상품 개수를 입력해 주세요 ! \n');
    String? inputCount = stdin.readLineSync();

    // 상품 명 및 상품 개수 입력값 검증
    Product product;
    try {
      product = products.firstWhere((p) => p.name == inputProductName);
    } catch (e) {
      print('입력값이 올바르지 않아요 !');
      return;
    }

    int count;
    try {
      count = int.parse(inputCount ?? '');
    } catch (e) {
      print('입력값이 올바르지 않아요 !');
      return;
    }
    if (count <= 0) {
      print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
      return;
    }

    // 장바구니에 상품 담기
    for (int i = 0; i < count; i++) {
      cart.add(product);
    }
    totalPrice += product.price * count;
    print('장바구니에 상품이 담겼어요 !');
  }

  // 필수 기능 3. 장바구니에 담은 상품의 총 가격을 출력
  void showTotal() {
    int totalPrice = cart.fold(0, (sum, product) => sum + product.price);
    print('장바구니에 $totalPrice원 어치를 담으셨네요 ! ');
  }
}
