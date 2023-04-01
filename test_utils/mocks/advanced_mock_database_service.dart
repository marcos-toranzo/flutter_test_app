import 'package:flutter_test_app/models/cart.dart';
import 'package:flutter_test_app/models/cart_entry.dart';
import 'package:flutter_test_app/models/model.dart';
import 'package:flutter_test_app/models/password.dart';
import 'package:flutter_test_app/models/user.dart';
import 'package:flutter_test_app/services/database_service/database_service.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/types.dart';

class AdvancedMockDatabaseService extends DatabaseService {
  var _idCount = 0;
  var _users = <User>[];
  var _carts = <Cart>[];
  var _cartEntries = <CartEntry>[];
  var _passwords = <Password>[];

  @override
  Future<Id> insert({
    required String tableName,
    required Model model,
  }) async {
    switch (tableName) {
      case User.tableName:
        _idCount++;
        final newUser = model as User;
        _users.add(
          User(
            id: _idCount,
            email: newUser.email,
            cartId: newUser.cartId,
          ),
        );
        break;
      case Cart.tableName:
        _idCount++;
        final newCart = model as Cart;
        _carts.add(
          Cart(
            id: _idCount,
            totalCount: newCart.totalCount,
          ),
        );
        break;
      case Password.tableName:
        _idCount++;
        final newPassowrd = model as Password;
        _passwords.add(
          Password(
            id: _idCount,
            userId: newPassowrd.userId,
            value: newPassowrd.value,
          ),
        );
        break;
      case CartEntry.tableName:
        _idCount++;
        final newCartEntry = model as CartEntry;
        _cartEntries.add(
          CartEntry(
            id: _idCount,
            bookId: newCartEntry.bookId,
            cartId: newCartEntry.cartId,
            count: newCartEntry.count,
          ),
        );
        break;
    }

    return _idCount;
  }

  @override
  Future<int> update({
    required String tableName,
    required Model model,
    List<WhereClause>? whereClauses,
  }) async {
    switch (tableName) {
      case User.tableName:
        final updatedUser = model as User;
        _users = _users.mapList(
          (user) => user.id == updatedUser.id ? updatedUser : user,
        );
        break;
      case Cart.tableName:
        final updatedCart = model as Cart;
        _carts = _carts.mapList(
          (cart) => cart.id == updatedCart.id ? updatedCart : cart,
        );
        break;
      case Password.tableName:
        final updatedPassword = model as Password;
        _passwords = _passwords.mapList(
          (password) =>
              password.id == updatedPassword.id ? updatedPassword : password,
        );
        break;
      case CartEntry.tableName:
        final updatedCartEntry = model as CartEntry;
        _cartEntries = _cartEntries.mapList(
          (cartEntry) => cartEntry.id == updatedCartEntry.id
              ? updatedCartEntry
              : cartEntry,
        );
        break;
    }

    return 1;
  }

  @override
  Future<int> delete({
    required String tableName,
    List<WhereClause>? whereClauses,
  }) async {
    final id = whereClauses![0].value as Id;
    var count = 1;

    switch (tableName) {
      case User.tableName:
        _users = _users.whereList((user) => user.id != id);
        break;
      case Cart.tableName:
        _carts = _carts.whereList((cart) => cart.id != id);
        break;
      case Password.tableName:
        _passwords = _passwords.whereList((password) => password.id != id);
        break;
      case CartEntry.tableName:
        if (whereClauses[0].column == CartEntry.columnCartId) {
          count =
              _cartEntries.where((cartEntry) => cartEntry.cartId == id).length;
          _cartEntries =
              _cartEntries.whereList((cartEntry) => cartEntry.cartId != id);
        } else {
          _cartEntries =
              _cartEntries.whereList((cartEntry) => cartEntry.id != id);
        }
        break;
    }

    return count;
  }

  @override
  Future<void> open(String name) async {}

  @override
  Future<List<Map<String, dynamic>>> get({
    required String tableName,
    List<String>? columns,
    List<WhereClause>? whereClauses,
  }) async {
    switch (tableName) {
      case User.tableName:
        Id? id;
        String? email;

        if (whereClauses != null) {
          for (var whereClause in whereClauses) {
            if (whereClause.column == User.columnEmail) {
              email = whereClause.value;
            } else if (whereClause.column == Model.columnId) {
              id = whereClause.value;
            }
          }
        }

        return _users.whereMapList(
          (user) =>
              (id == null || user.id == id) &&
              (email == null || user.email == email),
          (user) => user.toMap(),
        );
      case Cart.tableName:
        final id = whereClauses?[0].value;

        return _carts.whereMapList(
          (cart) => id == null || cart.id == id,
          (cart) => cart.toMap(),
        );
      case Password.tableName:
        Id? userId;
        String? value;

        if (whereClauses != null) {
          for (var whereClause in whereClauses) {
            if (whereClause.column == Password.columnUserId) {
              userId = whereClause.value;
            } else if (whereClause.column == Password.columnValue) {
              value = whereClause.value;
            }
          }
        }

        return _passwords.whereMapList(
          (password) =>
              (userId == null || password.userId == userId) &&
              (value == null || password.value == value),
          (password) => password.toMap(),
        );
      case CartEntry.tableName:
        Id? cartId;
        String? bookId;

        if (whereClauses != null) {
          for (var whereClause in whereClauses) {
            if (whereClause.column == CartEntry.columnCartId) {
              cartId = whereClause.value;
            } else if (whereClause.column == CartEntry.columnBookId) {
              bookId = whereClause.value;
            }
          }
        }

        return _cartEntries.whereMapList(
          (cartEntry) =>
              (cartId == null || cartEntry.cartId == cartId) &&
              (bookId == null || cartEntry.bookId == bookId),
          (cartEntry) => cartEntry.toMap(),
        );
    }

    return [];
  }
}
