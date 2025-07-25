//ecom screen

import 'package:agahi/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Domain { edu, health, ecom, agri }

class EcomItem {
  final String engName;
  final String psName;
  final String urName;
  final int price;
  final int rating;
  final String? imageUrl;
  final String imagePath;
  final Domain dom;
  final String? ytLink;

  EcomItem({
    required this.engName,
    required this.psName,
    required this.urName,
    required this.price,
    required this.rating,
    this.imageUrl,
    this.imagePath = '',
    required this.dom,
    this.ytLink,
  });
}

class EcomItems {
  static final List<EcomItem> items = [
    EcomItem(
      engName: 'Laptop',
      psName: 'لیپ ټاپ',
      urName: 'لیپ ٹاپ',
      price: 50000,
      rating: 4,
      imageUrl:
          "https://th.bing.com/th/id/R.bb11155b905a31d3398fd82bc00d7980?rik=bp4URAKmlQXzXQ&riu=http%3a%2f%2fwww.pngall.com%2fwp-content%2fuploads%2f2016%2f05%2fHand-Saw-PNG-Clipart.png&ehk=5Be7Bg0UJ3HQEjEdO%2fQ5MqA6Zh8nG9cNMyzMziWJZ2E%3d&risl=&pid=ImgRaw&r=0",
      imagePath: 'assets/images/laptop.png',
      dom: Domain.ecom,
    ),
    EcomItem(
      engName: 'Smartphone',
      psName: 'سمارټ فون',
      urName: 'سمارٹ فون',
      price: 30000,
      rating: 5,
      imageUrl:
          "https://th.bing.com/th/id/R.bb11155b905a31d3398fd82bc00d7980?rik=bp4URAKmlQXzXQ&riu=http%3a%2f%2fwww.pngall.com%2fwp-content%2fuploads%2f2016%2f05%2fHand-Saw-PNG-Clipart.png&ehk=5Be7Bg0UJ3HQEjEdO%2fQ5MqA6Zh8nG9cNMyzMziWJZ2E%3d&risl=&pid=ImgRaw&r=0",
      imagePath: 'assets/images/smartphone.png',
      dom: Domain.ecom,
    ),
    EcomItem(
      engName: 'Axe',
      psName: 'تبر',
      urName: 'کلہاڑی',
      price: 1000,
      rating: 4,
      imagePath: 'assets/images/axe.png',
      dom: Domain.agri,
    ),
    EcomItem(
      engName: 'Fertilizer',
      psName: 'سري',
      urName: 'کھاد',
      price: 2500,
      rating: 3,
      imageUrl:
          "https://th.bing.com/th/id/R.bb11155b905a31d3398fd82bc00d7980?rik=bp4URAKmlQXzXQ&riu=http%3a%2f%2fwww.pngall.com%2fwp-content%2fuploads%2f2016%2f05%2fHand-Saw-PNG-Clipart.png&ehk=5Be7Bg0UJ3HQEjEdO%2fQ5MqA6Zh8nG9cNMyzMziWJZ2E%3d&risl=&pid=ImgRaw&r=0",
      imagePath: 'assets/images/fertilizer.png',
      dom: Domain.agri,
    ),
    EcomItem(
      engName: 'Stethoscope',
      psName: 'سټیتوسکوپ',
      urName: 'سٹیتھوسکوپ',
      price: 1200,
      rating: 4,
      imageUrl:
          "https://th.bing.com/th/id/R.bb11155b905a31d3398fd82bc00d7980?rik=bp4URAKmlQXzXQ&riu=http%3a%2f%2fwww.pngall.com%2fwp-content%2fuploads%2f2016%2f05%2fHand-Saw-PNG-Clipart.png&ehk=5Be7Bg0UJ3HQEjEdO%2fQ5MqA6Zh8nG9cNMyzMziWJZ2E%3d&risl=&pid=ImgRaw&r=0",
      imagePath: 'assets/images/stethoscope.png',
      dom: Domain.health,
    ),
    EcomItem(
      engName: 'Bandage',
      psName: 'بندیز',
      urName: 'پٹی',
      price: 300,
      rating: 5,
      imageUrl:
          "https://th.bing.com/th/id/R.bb11155b905a31d3398fd82bc00d7980?rik=bp4URAKmlQXzXQ&riu=http%3a%2f%2fwww.pngall.com%2fwp-content%2fuploads%2f2016%2f05%2fHand-Saw-PNG-Clipart.png&ehk=5Be7Bg0UJ3HQEjEdO%2fQ5MqA6Zh8nG9cNMyzMziWJZ2E%3d&risl=&pid=ImgRaw&r=0",
      imagePath: 'assets/images/bandage.png',
      ytLink: '',
      dom: Domain.health,
    ),
    EcomItem(
      engName: 'Textbook',
      psName: 'درسي کتاب',
      urName: 'نصابی کتاب',
      price: 500,
      rating: 4,
      imageUrl:
          "https://th.bing.com/th/id/R.bb11155b905a31d3398fd82bc00d7980?rik=bp4URAKmlQXzXQ&riu=http%3a%2f%2fwww.pngall.com%2fwp-content%2fuploads%2f2016%2f05%2fHand-Saw-PNG-Clipart.png&ehk=5Be7Bg0UJ3HQEjEdO%2fQ5MqA6Zh8nG9cNMyzMziWJZ2E%3d&risl=&pid=ImgRaw&r=0",
      imagePath: 'assets/images/textbook.png',
      dom: Domain.edu,
    ),
    // Add more items as needed
  ];
}

class EcomScreen extends StatelessWidget {
  const EcomScreen({super.key});

  String _getLocalizedText(
    BuildContext context,
    String english,
    String pashto,
    String urdu,
  ) {
    final settings = context.watch<SettingsForAppProvider>();
    switch (settings.language) {
      case Lang.en:
        return english;
      case Lang.ps:
        return pashto;
      case Lang.ur:
        return urdu;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsForAppProvider>();
    final settingsNotifier = context.read<SettingsForAppProvider>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        title: Text(
          _getLocalizedText(context, 'E-commerce', 'بازار', 'تجارت'),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon:
                settings.voiceOn
                    ? const Icon(Icons.volume_up)
                    : const Icon(Icons.volume_off),
            onPressed: () {
              settingsNotifier.toggleVoice();
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: EcomItems.items.length,
        itemBuilder: (context, index) {
          final item = EcomItems.items[index];
          return EcomItemCard(item: item);
        },
      ),
    );
  }
}

class EcomItemCard extends StatelessWidget {
  final EcomItem item;

  const EcomItemCard({super.key, required this.item});

  String _getItemName(BuildContext context) {
    final settings = context.watch<SettingsForAppProvider>();
    // Return name based on selected language
    switch (settings.language) {
      case Lang.en:
        return item.engName;
      case Lang.ur:
        return item.urName;
      case Lang.ps:
        return item.psName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsForAppProvider>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    BuyItemScreen(item: item),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              // First try to load from URL, if null or fails, use asset image
              child:
                  item.imageUrl != null
                      ? CachedNetworkImage(
                        imageUrl: item.imageUrl!,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        placeholder:
                            (context, url) => const CircularProgressIndicator(),
                        errorWidget:
                            (context, url, error) => Image.asset(
                              item.imagePath,
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                      )
                      : Image.asset(
                        item.imagePath,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (settings.voiceOn)
                  Text(
                    _getItemName(context),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (settings.voiceOn) const SizedBox(height: 4),
                if (settings.voiceOn)
                  Text(
                    'PKR ${item.price}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                if (settings.voiceOn) const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < item.rating ? Icons.star : Icons.star_border,
                      size: 14,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Buy Item Screen
class BuyItemScreen extends StatelessWidget {
  final EcomItem item;

  const BuyItemScreen({super.key, required this.item});

  String _getItemName(BuildContext context) {
    final settings = context.watch<SettingsForAppProvider>();
    switch (settings.language) {
      case Lang.en:
        return item.engName;
      case Lang.ps:
        return item.psName;
      case Lang.ur:
        return item.urName;
    }
  }

  String _getLocalizedText(
    BuildContext context,
    String english,
    String pashto,
    String urdu,
  ) {
    final settings = context.watch<SettingsForAppProvider>();
    switch (settings.language) {
      case Lang.en:
        return english;
      case Lang.ps:
        return pashto;
      case Lang.ur:
        return urdu;
    }
  }

  Widget _buildStarRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 24,
        );
      }),
    );
  }

  void _showPurchaseConfirmationBottomSheet(BuildContext context) {
    final settings = context.read<SettingsForAppProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title
                    if (settings.voiceOn)
                      Text(
                        _getLocalizedText(
                          context,
                          'Purchase Confirmation',
                          'د پیرود تصدیق',
                          'خریداری کی تصدیق',
                        ),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (settings.voiceOn) const SizedBox(height: 24),

                    // Order Summary
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (settings.voiceOn)
                            Text(
                              _getLocalizedText(
                                context,
                                'Order Summary',
                                'د امر لنډیز',
                                'آرڈر کا خلاصہ',
                              ),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (settings.voiceOn) const SizedBox(height: 12),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: 120,
                                  height: 120,
                                  child:
                                      item.imageUrl != null
                                          ? CachedNetworkImage(
                                            imageUrl: item.imageUrl!,
                                            fit: BoxFit.cover,
                                            placeholder:
                                                (context, url) =>
                                                    const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          )
                                          : Image.asset(
                                            item.imagePath,
                                            fit: BoxFit.fitWidth,
                                          ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (settings.voiceOn)
                                      Text(
                                        _getItemName(context),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    if (settings.voiceOn)
                                      const SizedBox(height: 8),
                                    if (settings.voiceOn)
                                      Text(
                                        'روپے ${(item.price).toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Delivery Address
                    if (settings.voiceOn)
                      Text(
                        _getLocalizedText(
                          context,
                          'Delivery Address',
                          'د رسولو پته',
                          'ڈیلیوری کا پتہ',
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (settings.voiceOn) const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.blue[700]),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Charsadda Rd, Mardan, Khyber Pakhtunkhwa 23200',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Payment Options
                    if (settings.voiceOn)
                      Text(
                        _getLocalizedText(
                          context,
                          'Payment Options',
                          'د ورکړې لارې',
                          'ادائیگی کے طریقے',
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (settings.voiceOn) const SizedBox(height: 12),

                    // Payment method cards
                    _buildPaymentOption(
                      context,
                      'Visa Card',
                      'assets/images/payment/visa.png',
                      () => _processPayment(context, 'Visa Card'),
                    ),
                    const SizedBox(height: 8),
                    _buildPaymentOption(
                      context,
                      'EasyPaisa',
                      'assets/images/payment/easypaisa.png',
                      () => _processPayment(context, 'EasyPaisa'),
                    ),
                    const SizedBox(height: 8),
                    _buildPaymentOption(
                      context,
                      'JazzCash',
                      'assets/images/payment/jazzcash.png',
                      () => _processPayment(context, 'JazzCash'),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    String name,
    String imagePath,
    VoidCallback onTap,
  ) {
    final settings = context.watch<SettingsForAppProvider>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Payment method icon
            Container(
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[100],
              ),
              child: Image.asset(imagePath, width: 50, height: 50),
            ),
            const SizedBox(width: 16),
            if (settings.voiceOn)
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            if (!settings.voiceOn) const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  void _processPayment(BuildContext context, String paymentMethod) {
    final settings = context.read<SettingsForAppProvider>();
    Navigator.pop(context); // Close bottom sheet

    String imagePath;
    switch (paymentMethod) {
      case 'Visa Card':
        imagePath = 'assets/images/payment/visa.png';
        break;
      case 'EasyPaisa':
        imagePath = 'assets/images/payment/easypaisa.png';
        break;
      case 'JazzCash':
        imagePath = 'assets/images/payment/jazzcash.png';
        break;
      default:
        imagePath = ''; // Provide a default image or handle the case
    }

    // Show payment processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              settings.voiceOn
                  ? Text(
                    _getLocalizedText(
                      context,
                      'Processing Payment',
                      'د ورکړې پروسس',
                      'ادائیگی کی کارروائی',
                    ),
                  )
                  : null,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, width: 100, height: 80),
              const SizedBox(height: 16),
              const CircularProgressIndicator(color: Colors.black),
              const SizedBox(height: 16),
              if (settings.voiceOn)
                Text(
                  _getLocalizedText(
                    context,
                    'Please wait while we process your payment via $paymentMethod...',
                    'مهرباني وکړئ انتظار وکړئ کله چې موږ ستاسو د $paymentMethod له لارې ورکړه پروسس کوو...',
                    'برائے کرم انتظار کریں جب تک ہم آپ کی $paymentMethod کے ذریعے ادائیگی کو پروسیس کرتے ہیں...',
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        );
      },
    );

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context); // Close processing dialog

      // Show success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                settings.voiceOn
                    ? Text(
                      _getLocalizedText(
                        context,
                        'Payment Successful!',
                        'ورکړه بریالۍ وه!',
                        'ادائیگی کامیاب رہی!',
                      ),
                    )
                    : null,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 64),
                const SizedBox(height: 16),
                if (settings.voiceOn)
                  Text(
                    _getLocalizedText(
                      context,
                      'Your order has been placed successfully! You will receive a confirmation shortly.',
                      'ستاسو امر په بریالیتوب سره ورکړل شو! تاسو به ډیر ژر تصدیق ترلاسه کړئ.',
                      'آپ کا آرڈر کامیابی سے دے دیا گیا ہے! آپ کو جلد ہی تصدیق موصول ہوگی۔',
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context); // Close success dialog
                  Navigator.pop(context); // Go back to previous screen
                },
                child:
                    settings.voiceOn
                        ? Text(
                          _getLocalizedText(context, 'OK', 'سمه ده', 'ٹھیک ہے'),
                          style: const TextStyle(color: Colors.black),
                        )
                        : const Icon(Icons.check, color: Colors.black),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsForAppProvider>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0,
        title: Text(
          _getLocalizedText(context, 'Buy Item', 'توکي واخلئ', 'سامان خریدیں'),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Image
            Center(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child:
                      item.imageUrl != null
                          ? CachedNetworkImage(
                            imageUrl: item.imageUrl!,
                            fit: BoxFit.fill,
                            placeholder:
                                (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                            errorWidget:
                                (context, url, error) =>
                                    const Icon(Icons.error, size: 50),
                          )
                          : Image.asset(
                            item.imagePath,
                            fit: BoxFit.fill,
                            errorBuilder:
                                (context, error, stackTrace) => const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                ),
                          ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Item Name
            if (settings.voiceOn)
              Text(
                _getItemName(context),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

            if (settings.voiceOn) const SizedBox(height: 12),

            // Rating
            Row(
              children: [
                _buildStarRating(item.rating),
                const SizedBox(width: 8),
                // Text(
                //   '(${widget.item.rating}/5)',
                //   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                // ),
              ],
            ),

            const SizedBox(height: 20),

            // Price
            // Text(
            //   _getLocalizedText('Price:', 'بیه:', 'قیمت:') +
            //       widget.item.price.toString(),
            //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            // ),
            const SizedBox(height: 8),
            // Text(
            //   'PKR ${widget.item.price.toStringAsFixed(0)}',
            //   style: const TextStyle(
            //     fontSize: 32,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.green,
            //   ),
            // ),

            // Display notes
            Wrap(
              spacing: 5.0, // gap between adjacent chips
              runSpacing: 5.0, // gap between lines
              children:
                  getNotes(item.price).map((e) {
                    return SizedBox(width: 100, height: 50, child: e);
                  }).toList(),
            ),

            const SizedBox(height: 24),

            // Buy Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showPurchaseConfirmationBottomSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      size: 30,
                      color: Colors.white,
                    ),
                    if (settings.voiceOn)
                      Text(
                        _getLocalizedText(
                          context,
                          '    Buy Now',
                          '   اوس واخلئ',
                          '   ابھی خریدیں',
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Image> getNotes(int price) {
  List<Image> notes = [];

  if (price >= 5000) {
    int count = price ~/ 5000;
    for (int i = 0; i < count; i++) {
      notes.add(Image.asset('assets/images/payment/5000.png'));
    }
    price %= 5000;
  }

  if (price >= 1000) {
    int count = price ~/ 1000;
    for (int i = 0; i < count; i++) {
      notes.add(Image.asset('assets/images/payment/1000.png'));
    }
    price %= 1000;
  }

  if (price >= 500) {
    int count = price ~/ 500;
    for (int i = 0; i < count; i++) {
      notes.add(Image.asset('assets/images/payment/500.png'));
    }
    price %= 500;
  }

  if (price >= 100) {
    int count = price ~/ 100;
    for (int i = 0; i < count; i++) {
      notes.add(Image.asset('assets/images/payment/100.png'));
    }
    price %= 100;
  }

  if (price >= 50) {
    int count = price ~/ 50;
    for (int i = 0; i < count; i++) {
      notes.add(Image.asset('assets/images/payment/50.png'));
    }
    price %= 50;
  }

  return notes;
}
