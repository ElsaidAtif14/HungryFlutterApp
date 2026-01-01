import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/feature/auth/data/auth_repo.dart';
import 'package:hungry/feature/auth/data/user_model.dart';
import 'package:hungry/feature/home/data/model/product_model.dart';
import 'package:hungry/feature/home/data/repos/product_repo.dart';
import 'package:hungry/feature/home/widgets/card_item.dart';
import 'package:hungry/feature/home/widgets/food_category.dart';
import 'package:hungry/feature/home/widgets/search_field.dart';
import 'package:hungry/feature/home/widgets/user_header.dart';
import 'package:hungry/feature/product/view/product_details_view.dart';
import 'package:hungry/shared/custom_snack_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {
  List category = ['All', 'Combo', 'Sliders', 'Classic'];
  int selectedIndex = 0;
  bool isProductLoading = false;
  ProductRepo productRepo = ProductRepo();
  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = []; // ⬅️ قائمة البحث
  final AuthRepo authRepo = AuthRepo();
  UserModel? userModel;

  final TextEditingController searchController = TextEditingController();

  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errmsg = 'Error In profile';
      if (e is ApiError) {
        errmsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errmsg));
    }
  }

  Future<void> getProducts() async {
    setState(() {
      isProductLoading = true;
    });
    final productList = await productRepo.getProducts();
    setState(() {
      products = productList;
      filteredProducts = productList; // ⬅️ عرض كل المنتجات أولاً
      isProductLoading = false;
    });
  }

  // 🟢 فانكشن البحث
  void searchProducts(String query) {
    final filtered = products.where((product) {
      final nameLower = product.name.toLowerCase();
      final descLower = product.description.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower) || descLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredProducts = filtered;
    });
  }

  @override
  void initState() {
    getProducts();
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: isProductLoading,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  floating: false,
                  automaticallyImplyLeading: false,
                  scrolledUnderElevation: 0,
                  backgroundColor: Colors.white,
                  toolbarHeight: 200,
                  flexibleSpace: Column(
                    children: [
                      Gap(75),
                      UserHeader(userModel: userModel),
                      Gap(25),
                      SearchField(
                        controller: searchController,
                        onChanged: searchProducts, // ⬅️ ربط البحث
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Gap(25),
                      FoodCategory(
                        selectedIndex: selectedIndex,
                        category: category,
                      ),
                      Gap(25),
                    ],
                  ),
                ),
                SliverGrid.builder(
                  itemCount: isProductLoading ? 6 : filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    if (isProductLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: const CardItem(name: '', desc: '', rate: ''),
                      );
                    }
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsView(
                              productPrice: product.price,
                              productImage: product.image,
                              productId: product.id,
                              productName: product.name,
                            ),
                          ),
                        );
                      },
                      child: CardItem(
                        image: product.image,
                        name: product.name,
                        desc: product.description,
                        rate: product.price,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
