import 'package:agahi/ecom/ecom.dart';
import 'package:agahi/main.dart';
import 'package:flutter/material.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

List<EcomItem> medics = [
  EcomItem(
    engName: 'Zyrtec',
    psName: 'زیرټیک',
    urName: 'زیرٹیک',
    imageUrl: 'assets/images/supplements.png',
    price: 150,
    rating: 4,
    dom: Domain.health,
    imagePath: 'assets/health/medic1.png',
  ),
  EcomItem(
    engName: 'ColdCalm',
    psName: 'کولډ کالم',
    urName: 'کولڈ کام',
    imageUrl: 'assets/images/medicines.png',
    dom: Domain.health,
    price: 150,
    rating: 4,
    imagePath: 'assets/health/medic2.png',
  ),
  EcomItem(
    engName: 'Snez-Cure',
    psName: 'سنیز کیور',
    urName: 'سنیز کیور',
    imageUrl: 'assets/images/equipment.png',
    price: 600,
    rating: 4,
    dom: Domain.health,
    imagePath: 'assets/health/medic3.png',
  ),
];

//list of disease objects:
class Disease {
  final String name;
  final String description;
  final List<String?> imagePath;
  final List<String?> imgUrl;
  final List<EcomItem> medicines;

  Disease({
    required this.name,
    required this.description,
    this.imagePath = const [],
    this.imgUrl = const [],
    this.medicines = const [],
  });
}

List<Disease> diseases = [
  Disease(
    name: 'Cold & Flu',
    description: 'Common viral infections affecting the respiratory system',
    imagePath: ['assets/images/health/demo/sneeze1.png'],
    medicines: [medics[1]], // ColdCalm
  ),
  Disease(
    name: 'Allergies',
    description: 'Immune system reactions to allergens',
    imagePath: ['assets/images/health/demo/sneeze2.png'],
    medicines: [medics[0]], // Zyrtec
  ),
  Disease(
    name: 'Nasal Congestion',
    description: 'Blocked or stuffy nose condition',
    imagePath: ['assets/images/health/demo/sneeze3.png'],
    medicines: [medics[2]], // Snez-Cure
  ),
];

class _HealthScreenState extends State<HealthScreen> {
  String _getLocalizedText(String en, String ps, String ur) {
    switch (settings.language) {
      case Lang.en:
        return en;
      case Lang.ps:
        return ps;
      case Lang.ur:
        return ur;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0,
        title: Text(
          _getLocalizedText('Health', 'روغتیا', 'صحت'),
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
              // Implement voice toggle functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (settings.voiceOn)
              Text(
                _getLocalizedText(
                  'Common Diseases',
                  'عام ناروغۍ',
                  'عام بیماریاں',
                ),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (settings.voiceOn) const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: diseases.length,
                itemBuilder: (context, index) {
                  final disease = diseases[index];
                  return GestureDetector(
                    onTap: () {
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
                    child: Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
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
                                disease.imagePath.isNotEmpty
                                    ? disease.imagePath[0] ??
                                        'assets/health/disease_placeholder.png'
                                    : 'assets/health/disease_placeholder.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder:
                                    (context, error, stackTrace) => const Icon(
                                      Icons.medical_services,
                                      size: 50,
                                    ),
                              ),
                            ),
                          ),
                          if (settings.voiceOn)
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                disease.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Disease Detail Screen
class DiseaseDetailScreen extends StatefulWidget {
  final Disease disease;
  final int diseaseIndex;

  const DiseaseDetailScreen({
    super.key,
    required this.disease,
    required this.diseaseIndex,
  });

  @override
  State<DiseaseDetailScreen> createState() => _DiseaseDetailScreenState();
}

class _DiseaseDetailScreenState extends State<DiseaseDetailScreen> {
  String _getLocalizedText(String en, String ps, String ur) {
    switch (settings.language) {
      case Lang.en:
        return en;
      case Lang.ps:
        return ps;
      case Lang.ur:
        return ur;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0,
        title: Text(
          settings.voiceOn
              ? widget.disease.name
              : 'Disease ${widget.diseaseIndex + 1}',
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
              setState(() {
                settings.toggleVoice();
              });
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

            // Disease Images
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.disease.imagePath.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.disease.imagePath[index] ??
                            'assets/health/disease_placeholder.png',
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.medical_services,
                                size: 50,
                              ),
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // Medicines Section
            if (settings.voiceOn)
              Text(
                _getLocalizedText('Medicines', 'درمل', 'دوائیاں'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (settings.voiceOn) const SizedBox(height: 16),

            // Buy Medicine Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    widget.disease.medicines.isNotEmpty
                        ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BuyItemScreen(
                                    item: widget.disease.medicines[0],
                                  ),
                            ),
                          );
                        }
                        : null,
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
                    const Icon(Icons.shopping_cart, size: 24),
                    if (settings.voiceOn) ...[
                      const SizedBox(width: 8),
                      Text(
                        _getLocalizedText(
                          'Buy Medicine',
                          'درمل واخلئ',
                          'دوا خریدیں',
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
