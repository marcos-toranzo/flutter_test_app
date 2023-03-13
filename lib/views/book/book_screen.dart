import 'package:flutter/material.dart';
import 'package:flutter_test_app/app_configuration.dart';
import 'package:flutter_test_app/controllers/cart_controller.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/notifications.dart';
import 'package:flutter_test_app/views/book/book_description.dart';
import 'package:flutter_test_app/views/book/book_details.dart';
import 'package:flutter_test_app/views/book/book_header.dart';
import 'package:flutter_test_app/views/book/book_reviews_price_and_page_count.dart';
import 'package:flutter_test_app/views/book/book_screen_controller.dart';
import 'package:flutter_test_app/views/book/book_title_and_authors.dart';
import 'package:flutter_test_app/views/cart/cart_screen.dart';
import 'package:flutter_test_app/widgets/column_with_padding.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/page_with_loader.dart';
import 'package:flutter_test_app/widgets/space.dart';
import 'package:flutter_test_app/widgets/buttons/wide_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BookScreen extends StatelessWidget {
  static const String routeName = '/book';

  final CartController _cartController = Get.find();

  BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);
    final bookId = RouteArguments.of(context).bookId!;

    final controller = Get.put(
      BookScreenController(
        bookId: bookId,
        cartController: _cartController,
        onErrorFetchingBook: () {
          showSnackBar(context: context, text: translations.errorFetchingBook);
        },
      ),
    );

    return Obx(
      () {
        final book = controller.book;

        final isForSale = book?.saleability == BookSaleability.forSale ||
            book?.saleability == BookSaleability.free;

        return PageWithLoader(
          loaderText: translations.loading,
          showLoader: controller.isLoading,
          child: Scaffold(
            appBar: CustomAppBar(
              titleText: translations.bookDetails,
              onRefresh: controller.onRefresh,
            ),
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: isForSale
                ? WideButton(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    text: translations.addToCart,
                    iconData: FontAwesomeIcons.cartShopping,
                    onPressed: () {
                      controller.onAddToCart(
                        onError: () {
                          showSnackBar(
                            context: context,
                            text: translations.errorAddingToCart,
                          );
                        },
                        onSuccess: () {
                          routingService.pushRoute(
                            context: context,
                            routeName: CartScreen.routeName,
                            routeArguments: RouteArguments(
                              transition: ScreenTransitions.slide,
                            ),
                          );
                        },
                      );
                    },
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: book != null
                ? ListView(
                    padding: EdgeInsets.only(bottom: isForSale ? 120 : 60),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      BookHeader(
                        imageLink: book.imageLink,
                      ),
                      const Space.vertical(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: BookTitleAndAuthors(
                          title: book.title,
                          authors: book.authors,
                        ),
                      ),
                      const Space.vertical(20),
                      BookPriceReviewAndPageCount(
                        price: book.price,
                        pageCount: book.pageCount,
                        ratings: book.ratings,
                        saleability: book.saleability,
                      ),
                      const Space.vertical(20),
                      ColumnWithPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        children: [
                          BookDetails(book: book),
                          if (book.description != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: BookDescription(
                                description: book.description!,
                              ),
                            ),
                        ],
                      ),
                    ],
                  )
                : null,
          ),
        );
      },
    );
  }
}
