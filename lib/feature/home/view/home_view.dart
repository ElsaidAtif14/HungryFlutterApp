import 'package:flutter/material.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/feature/auth/data/auth_repo.dart';
import 'package:hungry/feature/auth/data/user_model.dart';
import 'package:hungry/feature/home/data/model/product_model.dart';
import 'package:hungry/feature/home/data/repos/product_repo.dart';
import 'package:hungry/feature/home/widgets/home_app_bar.dart';
import 'package:hungry/feature/home/widgets/home_products_grid.dart';
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
      child: RefreshIndicator(
        onRefresh: getProfileData,
        child: Scaffold(
          body: Skeletonizer(
            enabled: isProductLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomScrollView(
                clipBehavior: Clip.none,
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    elevation: 0,
                    floating: false,
                    automaticallyImplyLeading: false,
                    scrolledUnderElevation: 0,
                    backgroundColor: Colors.white,
                    toolbarHeight: 200,
                    flexibleSpace: HomeAppBar(
                      userModel: userModel,
                      searchController: searchController,
                      onSearchChanged: searchProducts,
                    ),
                  ),
                  HomeProductsGrid(
                    selectedIndex: selectedIndex,
                    category: category,
                    filteredProducts: filteredProducts,
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 200)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
