import 'package:flutter/material.dart';
import 'package:flutter_test_app/services/routing_service/routing_service.dart';
import 'package:flutter_test_app/utils/localization.dart';
import 'package:flutter_test_app/utils/notifications.dart';
import 'package:flutter_test_app/views/category/category_screen_controller.dart';
import 'package:flutter_test_app/widgets/book/book_preview.dart';
import 'package:flutter_test_app/widgets/custom_appbar.dart';
import 'package:flutter_test_app/widgets/screen_with_loader.dart';
import 'package:flutter_test_app/widgets/sort_by_price_button.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  static const String routeName = '/category';

  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppTranslations.of(context);
    final categoryName = RouteArguments.of(context).categoryName!;

    final controller = Get.put(
      CategoryScreenController(
        categoryName: categoryName,
        onErrorFetchingBooks: () {
          showSnackBar(context: context, text: translations.errorFetchingBooks);
        },
      ),
    );

    return Obx(
      () {
        final books = controller.bookCategory?.books;

        return ScreenWithLoader(
          isLoading: controller.isLoading,
          appBar: CustomAppBar(
            titleText: translations.categoryName(categoryName),
            onRefresh: controller.onRefresh,
            isRefreshing: controller.isLoading,
          ),
          body: books != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: SortByPriceButton(
                            backgroundColor: Theme.of(context).cardColor,
                            onSort: controller.onSortByPrice,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: 8,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 130,
                          mainAxisExtent: 200,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: books.length,
                        itemBuilder: (_, index) => BookPreview(
                          key: ValueKey('book#${books[index].id}'),
                          book: books[index],
                        ),
                      ),
                    ),
                  ],
                )
              : null,
        );
      },
    );
  }
}
