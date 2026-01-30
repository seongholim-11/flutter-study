void main() {
  // 1단계 과제 코드를 여기에 작성하세요.
  final myName = '임성호';
  const myFavoriteNumber = 3;
  var now = DateTime.now();

  final myFavoriteFruits = ['apple', 'strawberry', 'banana'];
  Map<String, dynamic> myProfile = {
    'name': myName,
    'favoriteNumber': myFavoriteNumber,
    'favoriteFruits': myFavoriteFruits[1],
  };

  String? nullableString;
  nullableString = 'Hello, Dart!';

  String multiply(int a, int b) {
    return '결과는 ${a * b}입니다.';
  }

  print(multiply(myFavoriteNumber, 10));
  print('My Name: $myName');
  print('Favorite Number: $myFavoriteNumber');
  print('Now: $now');
  print('Favorite Fruits: $myFavoriteFruits');
  print('My Profile: $myProfile');
  print('Nullable String: $nullableString');
}
