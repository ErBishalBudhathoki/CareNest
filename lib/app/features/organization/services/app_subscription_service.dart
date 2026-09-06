import 'dart:io';

import 'package:carenest/config/build_config.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class AppSubscriptionService {
  AppSubscriptionService({InAppPurchase? store})
    : _store = store ?? InAppPurchase.instance;

  final InAppPurchase _store;

  Stream<List<PurchaseDetails>> get purchaseUpdates => _store.purchaseStream;

  String get monthlyProductId {
    if (Platform.isIOS) return BuildConfig.iosMonthlySubscriptionId;
    if (Platform.isAndroid) return BuildConfig.androidMonthlySubscriptionId;
    return '';
  }

  Future<ProductDetails> loadMonthlyProduct() async {
    final productId = monthlyProductId;
    if (productId.isEmpty) {
      throw StateError('The monthly app subscription is not configured');
    }
    if (!await _store.isAvailable()) {
      throw StateError('The app store is unavailable');
    }

    final response = await _store.queryProductDetails({productId});
    if (response.error != null || response.productDetails.length != 1) {
      throw StateError('The monthly app subscription is unavailable');
    }
    return response.productDetails.single;
  }

  Future<bool> purchaseMonthly(ProductDetails product) {
    return _store.buyNonConsumable(
      purchaseParam: PurchaseParam(productDetails: product),
    );
  }

  Future<void> restorePurchases() => _store.restorePurchases();

  Future<void> completeVerifiedPurchase(PurchaseDetails purchase) async {
    if (purchase.pendingCompletePurchase) {
      await _store.completePurchase(purchase);
    }
  }
}
