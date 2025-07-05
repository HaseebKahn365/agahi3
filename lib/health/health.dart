import 'package:agahi/ecom/ecom.dart';
import 'package:agahi/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//disease object
class Disease {
  final String name;
  final List<String> imageAssetsPaths;
  final List<String> imageUrlsPaths;
  final List<EcomItem>? medicines;
  Disease({
    required this.name,
    required this.imageAssetsPaths,
    required this.imageUrlsPaths,
    this.medicines,
  });
}

final List<Disease> diseases = [
  Disease(
    name: 'Disease1',
    imageAssetsPaths: [
      'assets/images/health/demo/sneeze1.png',
      'assets/images/health/demo/sneeze2.png',
      'assets/images/health/demo/sneeze3.png',
    ],
    imageUrlsPaths: [
      'https://cdn.mos.cms.futurecdn.net/VvFhGHVSaSeQApKMs3Yd2F.jpg',
    ],

    medicines: [
      EcomItem(
        engName: 'Medicine 1',
        psName: 'بندیز',
        urName: 'پٹی',
        price: 500,
        rating: 5,
        imagePath: 'assets/images/health/demo_medics/medic1.png',
        dom: Domain.health,
      ),
      EcomItem(
        engName: 'Medicine 2',
        psName: 'درمل ۲',
        urName: 'دوا ۲',
        price: 200,
        rating: 4,
        imagePath: 'assets/images/health/demo_medics/medic2.png',
        dom: Domain.health,
      ),
      EcomItem(
        engName: 'Medicine 3',
        psName: 'درمل ۳',
        urName: 'دوا ۳',
        price: 350,
        rating: 4,
        imagePath: 'assets/images/health/demo_medics/medic3.png',
        dom: Domain.health,
      ),
    ],
  ),
  Disease(
    name: 'Disease2',
    imageAssetsPaths: [
      'assets/images/health/demo/sneeze1.png',
      'assets/images/health/demo/sneeze2.png',
      'assets/images/health/demo/sneeze3.png',
    ],
    imageUrlsPaths: [
      'https://cdn.mos.cms.futurecdn.net/VvFhGHVSaSeQApKMs3Yd2F.jpg',
    ],
  ),

  Disease(
    name: 'Disease3',
    imageAssetsPaths: [
      'assets/images/health/demo/sneeze1.png',
      'assets/images/health/demo/sneeze2.png',
      'assets/images/health/demo/sneeze3.png',
    ],
    imageUrlsPaths: [
      'https://cdn.mos.cms.futurecdn.net/VvFhGHVSaSeQApKMs3Yd2F.jpg',
    ],
  ),
];

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

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
          _getLocalizedText(context, 'Health', 'صحت', 'صحت'),
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          final disease = diseases[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        disease.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        //navigate to the disease detail screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DiseaseDetailScreen(
                                  disease: disease,
                                  diseaseIndex: index,
                                ),
                          ),
                        );
                      },
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...disease.imageAssetsPaths.map((path) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    path,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                            ...disease.imageUrlsPaths.map((url) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: url,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) => Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    errorWidget:
                                        (context, url, error) =>
                                            Icon(Icons.error),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          );
        },
        itemCount: diseases.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}

// Disease Detail Screen
class DiseaseDetailScreen extends StatelessWidget {
  final Disease disease;
  final int diseaseIndex;

  const DiseaseDetailScreen({
    super.key,
    required this.disease,
    required this.diseaseIndex,
  });

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

  String _getMedicineName(BuildContext context, EcomItem medicine) {
    final settings = context.watch<SettingsForAppProvider>();
    switch (settings.language) {
      case Lang.en:
        return medicine.engName;
      case Lang.ps:
        return medicine.psName;
      case Lang.ur:
        return medicine.urName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsForAppProvider>();
    final settingsNotifier = context.read<SettingsForAppProvider>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0,
        title: Text(
          settings.voiceOn ? disease.name : 'Disease ${diseaseIndex + 1}',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Disease Images Section
            if (settings.voiceOn)
              Text(
                _getLocalizedText(
                  context,
                  'Disease Images',
                  'د ناروغۍ انځورونه',
                  'بیماری کی تصاویر',
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (settings.voiceOn) const SizedBox(height: 16),

            // Disease Images Horizontal Scroll
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    disease.imageAssetsPaths.length +
                    disease.imageUrlsPaths.length,
                itemBuilder: (context, index) {
                  // Show asset images first, then URL images
                  if (index < disease.imageAssetsPaths.length) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 250,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            disease.imageAssetsPaths[index],
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.medical_services,
                                    size: 60,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    // URL images
                    int urlIndex = index - disease.imageAssetsPaths.length;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 250,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: disease.imageUrlsPaths[urlIndex],
                            fit: BoxFit.cover,
                            placeholder:
                                (context, url) => Container(
                                  color: Colors.grey[100],
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            errorWidget:
                                (context, url, error) => Container(
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.error, size: 60),
                                ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),

            const SizedBox(height: 40),

            // Medicines Section
            if (disease.medicines != null && disease.medicines!.isNotEmpty) ...[
              // Medicine Images Horizontal Scroll
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: disease.medicines!.length,
                  itemBuilder: (context, index) {
                    final medicine = disease.medicines![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BuyItemScreen(item: medicine),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 250,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15),
                                  ),
                                  child: Image.asset(
                                    medicine.imagePath,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              color: Colors.grey[200],
                                              child: const Icon(
                                                Icons.medication,
                                                size: 60,
                                              ),
                                            ),
                                  ),
                                ),
                              ),
                              if (settings.voiceOn)
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    _getMedicineName(context, medicine),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Medicines Label
              if (settings.voiceOn)
                Center(
                  child: Text(
                    _getLocalizedText(context, 'Medicines', 'درمل', 'دوائیاں'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // Buy Medicine Button
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      if (disease.medicines!.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    BuyItemScreen(item: disease.medicines![0]),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:
                        settings.voiceOn
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.shopping_cart, size: 24),
                                const SizedBox(width: 10),
                                Text(
                                  _getLocalizedText(
                                    context,
                                    'Buy Medicine',
                                    'درمل واخلئ',
                                    'دوا خریدیں',
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                            : const Icon(Icons.shopping_cart, size: 24),
                  ),
                ),
              ),
            ] else ...[
              // No medicines available
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    settings.voiceOn
                        ? _getLocalizedText(
                          context,
                          'No medicines available for this disease',
                          'د دې ناروغۍ لپاره هیڅ درمل شتون نلري',
                          'اس بیماری کے لیے کوئی دوا دستیاب نہیں',
                        )
                        : '',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
