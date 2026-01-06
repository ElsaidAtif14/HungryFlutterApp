# 🚀 GoRouter Implementation Guide

## نظرة عامة
تم تحديث التطبيق لاستخدام **GoRouter** - حل توجيه حديث وفعال للتطبيقات من Flutter

## الملفات المُحدثة

### 1. **app_router.dart** (الملف الرئيسي للتوجيه)
- ✅ تم إنشاء `AppRoutes` - class يحتوي على جميع routes الثابتة
- ✅ تم إعادة تنظيم `GoRouter` مع routes منظمة وواضحة
- ✅ تم إضافة extension methods على `BuildContext` لتسهيل الملاحة

### 2. **الملفات المُحدثة للملاحة**

#### ملفات المصادقة:
- ✅ `login_view.dart` - استخدام `context.go(AppRoutes.root)` بدلاً من Navigator
- ✅ `signup_view.dart` - استخدام GoRouter للملاحة
- ✅ `profile_view.dart` - استخدام `context.go(AppRoutes.login)` عند تسجيل الخروج

#### ملفات أخرى:
- ✅ `home_products_grid.dart` - استخدام `context.goProductDetails()` عند اختيار منتج
- ✅ `cart_bottom_sheet.dart` - استخدام GoRouter للانتقال للـ checkout
- ✅ `check_out_view.dart` - استخدام `context.pop()` للرجوع
- ✅ `main.dart` - التحقق من استخدام `MaterialApp.router`

---

## 📝 كيفية الاستخدام

### استدعاء الملاحة:

```dart
// الملاحة البسيطة
context.goHome();           // إلى الصفحة الرئيسية
context.goLogin();          // تسجيل الدخول
context.goCart();           // السلة
context.goProfile();        // الملف الشخصي

// الملاحة مع معاملات
context.goProductDetails(
  productId: 1,
  productImage: 'image_url',
  productName: 'Product Name',
  productPrice: '99.99',
);

// الرجوع
context.pop();

// إعادة تعيين الـ Stack (الذهاب للصفحة الأولى)
context.goSplash();
```

### استخدام named routes:

```dart
// يمكن الآن استخدام أسماء routes للمزيد من المرونة
AppRoutes.splash      // '/'
AppRoutes.root        // '/root'
AppRoutes.login       // '/login'
AppRoutes.signup      // '/signup'
AppRoutes.cart        // '/cart'
AppRoutes.checkout    // '/checkout'
AppRoutes.profile     // '/profile'
```

---

## 🎯 المميزات:

### ✨ قبل (النمط القديم):
```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const NextPage(),
  ),
);
```

### ✨ بعد (GoRouter):
```dart
context.go(AppRoutes.nextPage);
```

---

## 📊 البنية الجديدة:

```
AppRouter
├── Routes
│   ├── Splash (/)
│   ├── Root (/root)
│   ├── Home (home) - nested
│   ├── Login (/login)
│   ├── Signup (/signup)
│   ├── Product Details (/product-details)
│   ├── Cart (/cart)
│   ├── Checkout (/checkout)
│   ├── Order History (/order-history)
│   └── Profile (/profile)
│
└── Extension Methods (على BuildContext)
    ├── goHome()
    ├── goProductDetails()
    ├── goCart()
    ├── goCheckout()
    ├── goLogin()
    ├── goSignup()
    ├── goOrderHistory()
    ├── goProfile()
    ├── goSplash()
    ├── pushProductDetails()
    └── popRoute()
```

---

## 🔄 تدفق المصادقة:

1. **تسجيل دخول ناجح** → `context.go(AppRoutes.root)`
2. **تسجيل خروج** → `context.go(AppRoutes.login)`
3. **الانتقال بين صفحات الملف الشخصي** → استخدام `context.pop()`

---

## ⚙️ التكوين:

**main.dart:**
```dart
MaterialApp.router(
  routerConfig: AppRouter.router,
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    splashColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.white,
  ),
)
```

---

## 📚 مراجع مفيدة:

- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Navigation Cookbook](https://docs.flutter.dev/cookbook#navigation)

---

## 🎉 الفوائد:

✅ **إدارة routes مركزية** - جميع الـ routes في مكان واحد
✅ **تقليل الأخطاء** - أسماء routes ثابتة توفر أمان الأنواع
✅ **سهولة الصيانة** - تحديثات routing سهلة وآمنة
✅ **أداء أفضل** - GoRouter أسرع وأخف من Navigator العادي
✅ **دعم Deep Linking** - إمكانية الارتباط العميق بسهولة

---

