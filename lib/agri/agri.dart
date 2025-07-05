import 'package:agahi/ecom/ecom.dart';
import 'package:agahi/main.dart';
import 'package:flutter/material.dart';

//tools for
List<EcomItem> agriItem = [
  //shovel : https://www.youtube.com/watch?v=o9FuFIY-OKA
  EcomItem(
    engName: 'Shovel',
    psName: 'بیلچه',
    urName: 'بیلچہ',
    price: 2500,
    rating: 4,
    imageUrl:
        "https://toppng.com/public/uploads/preview/shovel-11530930535gmgyjj32zv.png",
    ytLink: 'https://www.youtube.com/watch?v=o9FuFIY-OKA',
    dom: Domain.agri,
  ),
  //rake : https://www.youtube.com/watch?v=o9FuFIY-OKA
  EcomItem(
    engName: 'Rake',
    psName: 'کنگھی',
    urName: 'کنگھی',
    price: 1800,
    rating: 4,
    imageUrl:
        "https://png.pngtree.com/png-vector/20220705/ourmid/pngtree-rake-garden-tool-png-image_5687479.png",
    ytLink: 'https://www.youtube.com/watch?v=o9FuFIY-OKA',
    dom: Domain.agri,
  ),
];

/*//youtube player widget:
class YoutubeVideoPlayer extends StatefulWidget {
  final String youtubeUrl;
  final bool shouldPlay;
  final double optionalHeight;

  const YoutubeVideoPlayer({
    super.key,
    required this.youtubeUrl,
    this.shouldPlay = false,
    this.optionalHeight = 400.0,
  });

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
} */

class AgriScreen extends StatefulWidget {
  const AgriScreen({super.key});

  @override
  State<AgriScreen> createState() => _AgriScreenState();
}

class _AgriScreenState extends State<AgriScreen> {
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

  String _getToolName(EcomItem item) {
    switch (settings.language) {
      case Lang.en:
        return item.engName;
      case Lang.ps:
        return item.psName;
      case Lang.ur:
        return item.urName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0,
        title: Text(
          _getLocalizedText('Agriculture', 'کرنه', 'زراعت'),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: agriItem.length,
        itemBuilder: (context, index) {
          final item = agriItem[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tool name with icon
                if (settings.voiceOn)
                  Row(
                    children: [
                      const Icon(Icons.build, color: Colors.green, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        _getToolName(item),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                if (settings.voiceOn) const SizedBox(height: 16),

                // Video player container
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: YoutubeVideoPlayer(
                      youtubeUrl: item.ytLink ?? '',
                      shouldPlay: false,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Buy button and price row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Buy button
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BuyItemScreen(item: item),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
                      label:
                          settings.voiceOn
                              ? Text(
                                _getLocalizedText('Buy', 'واخلئ', 'خریدیں'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                              : const SizedBox.shrink(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: settings.voiceOn ? 24 : 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    // Price
                    if (settings.voiceOn)
                      Text(
                        'Rs. ${item.price}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
