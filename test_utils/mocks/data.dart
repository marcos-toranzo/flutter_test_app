import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/models/password.dart';
import 'package:flutter_test_app/models/user.dart';

Cart mockCart = Cart(id: 1);

User mockUser = User(
  id: 1,
  email: 'user@email.com',
  cartId: mockCart.id,
);

Password mockPassword = Password(
  value: 'a',
  userId: mockUser.id,
  id: 1,
);
