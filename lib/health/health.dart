import 'package:agahi/main.dart';
import 'package:flutter/material.dart';

//disease object
class Disease {
  final String name;
  final List<String> imageAssetsPaths;
  final List<String> imageUrlsPaths;
  Disease({
    required this.name,
    required this.imageAssetsPaths,
    required this.imageUrlsPaths,
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

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  String _getLocalizedText(String english, String pashto, String urdu) {
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        title: Text(
          _getLocalizedText('Health', 'صحت', 'صحت'),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon:
                !settings.voiceOn
                    ? Icon(Icons.volume_up)
                    : Icon(Icons.volume_off),
            onPressed: () {
              setState(() {
                settings.toggleVoice();
              });
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
                    SingleChildScrollView(
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
                                child: Image.network(
                                  // Assuming cached_network_image is not a dependency. Use Image.network for simplicity.
                                  url,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (
                                    BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress,
                                  ) {
                                    if (loadingProgress == null) return child;
                                    return SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value:
                                              loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Icon(Icons.error),
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                        ],
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
