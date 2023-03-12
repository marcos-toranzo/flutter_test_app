import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test_app/models/book.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/utils/currency.dart';
import 'package:flutter_test_app/utils/iterable_utils.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/notifications.dart';
import 'package:flutter_test_app/utils/styling.dart';
import 'package:flutter_test_app/views/book/book_controller.dart';
import 'package:flutter_test_app/widgets/book_image.dart';
import 'package:flutter_test_app/widgets/book_price_tag.dart';
import 'package:flutter_test_app/widgets/column_with_padding.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/cutom_text.dart';
import 'package:flutter_test_app/widgets/page_with_loader.dart';
import 'package:flutter_test_app/widgets/space.dart';
import 'package:flutter_test_app/widgets/wide_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

Color _getLighterTextColor(BuildContext context) =>
    Theme.of(context).colorScheme.onBackground.withAlpha(150);

TextStyle? _getBigTextStyle(BuildContext context) =>
    Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        );

class BookScreen extends StatelessWidget {
  static const String routeName = '/book';

  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);
    final bookId = RouteArguments.of(context).bookId!;

    final controller = Get.put(
      BookController(
        bookId: bookId,
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
            floatingActionButton: isForSale
                ? WideButton(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    text: translations.addToCart,
                    iconData: FontAwesomeIcons.cartShopping,
                    // TODO: go to cart screen
                    onPressed: () {},
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: book != null
                ? ListView(
                    padding: EdgeInsets.only(bottom: isForSale ? 120 : 60),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _BookHeader(
                        imageLink: book.imageLink,
                      ),
                      const Space.vertical(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: _BookTitleAndAuthors(
                          title: book.title,
                          authors: book.authors,
                        ),
                      ),
                      const Space.vertical(20),
                      _BookPriceReviewAndPageCount(
                        price: book.price,
                        pageCount: book.pageCount,
                        ratings: book.ratings,
                        saleability: book.saleability,
                      ),
                      const Space.vertical(20),
                      ColumnWithPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        children: [
                          _BookDetails(book: book),
                          if (book.description != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: _BookDescription(
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

class _BookHeader extends StatelessWidget {
  final String? imageLink;

  const _BookHeader({required this.imageLink});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(40),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(borderRadiusValue * 3),
              bottomRight: Radius.circular(borderRadiusValue * 3),
            ),
          ),
          height: 180,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: BookImage(
            imageUrl: imageLink,
            elevation: 0,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class _BookTitleAndAuthors extends StatelessWidget {
  final String? title;
  final List<String>? authors;

  const _BookTitleAndAuthors({
    required this.title,
    required this.authors,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return Column(
      children: [
        OnBackgroundText(
          title ?? translations.untitled,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Space.vertical(8),
        const Divider(
          thickness: 0.1,
          height: 8,
          endIndent: 30,
          indent: 30,
        ),
        ...(authors != null
            ? authors!.mapList(
                (author) => Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: OnBackgroundText(
                    author,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
            : [OnBackgroundText(translations.unknownAuthors)])
      ],
    );
  }
}

class _BookPriceReviewAndPageCount extends StatelessWidget {
  final Currency? price;
  final BookSaleability saleability;
  final BookRatings? ratings;
  final int? pageCount;

  const _BookPriceReviewAndPageCount({
    required this.price,
    required this.saleability,
    required this.ratings,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return Row(
      children: [
        Expanded(
          child: Center(
            child: ratings == null
                ? OnBackgroundText(translations.nReviews(0))
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBar.builder(
                            initialRating: ratings!.average ?? 0,
                            minRating: 1,
                            maxRating: 5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (_, __) => Icon(
                              Icons.star,
                              color: Theme.of(context).primaryColor,
                            ),
                            itemSize: 16,
                            onRatingUpdate: (_) {},
                            ignoreGestures: true,
                          ),
                          const Space.horizontal(5),
                          OnBackgroundText(
                              ratings!.average?.toString() ?? '0.0')
                        ],
                      ),
                      OnBackgroundText(
                          translations.nReviews(ratings!.count ?? 0))
                    ],
                  ),
          ),
        ),
        BookPriceTag(
          price: price,
          saleability: saleability,
        ),
        Expanded(
          child: OnBackgroundText(
            translations.nPages(pageCount?.toString() ?? '?'),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class _BookDetails extends StatelessWidget {
  final Book book;

  const _BookDetails({required this.book});

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    const space = 3.0;

    buildDetailHeader(String text) => Padding(
          padding: const EdgeInsets.only(bottom: space),
          child: OnBackgroundText(text),
        );

    buildDetailValue(String text) => Padding(
          padding: const EdgeInsets.only(bottom: space),
          child: Text(
            text,
            style: TextStyle(color: _getLighterTextColor(context)),
          ),
        );

    final publisher = book.publisher;
    final publishedDate = book.publishedDate;
    final language = book.language;
    final categories = book.categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnBackgroundText(
          translations.details,
          style: _getBigTextStyle(context),
        ),
        const Space.vertical(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (publisher != null)
                  buildDetailHeader(translations.publisher),
                if (publishedDate != null)
                  buildDetailHeader(translations.publishedDate),
                if (language != null) buildDetailHeader(translations.language),
                if (categories != null)
                  buildDetailHeader(
                    translations.categories(categories.length),
                  ),
              ],
            ),
            const Space.horizontal(14),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (publisher != null) buildDetailValue(publisher),
                  if (publishedDate != null) buildDetailValue(publishedDate),
                  if (language != null) buildDetailValue(language),
                  if (categories != null)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categories.mapList(
                        (category) => buildDetailValue(
                          '${categories.length > 1 ? '• ' : ''}$category',
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BookDescription extends StatelessWidget {
  final String description;

  const _BookDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnBackgroundText(
          translations.description,
          style: _getBigTextStyle(context),
        ),
        const Space.vertical(10),
        Text(
          description,
          textAlign: TextAlign.justify,
          style: TextStyle(color: _getLighterTextColor(context)),
        ),
      ],
    );
  }
}
