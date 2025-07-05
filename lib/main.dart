// ignore_for_file: library_private_types_in_public_api

import 'package:agahi/agri/agri.dart';
import 'package:agahi/custom_wids.dart';
import 'package:agahi/ecom/ecom.dart';
import 'package:agahi/health/health.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

enum Lang { ps, ur, en } //pashto, urdu, and english

class SettingsForAppProvider with ChangeNotifier {
  Lang _language = Lang.en;
  bool _voiceOn = true;

  Lang get language => _language;
  bool get voiceOn => _voiceOn;

  void switchLanguage(Lang newLang) {
    _language = newLang;
    notifyListeners();
  }

  void toggleVoice() {
    _voiceOn = !_voiceOn;
    notifyListeners();
  }

  String getLocalizedText(String english, String pashto, String urdu) {
    switch (_language) {
      case Lang.en:
        return english;
      case Lang.ps:
        return pashto;
      case Lang.ur:
        return urdu;
    }
  }

  String getToolName(EcomItem item) {
    switch (_language) {
      case Lang.en:
        return item.engName;
      case Lang.ps:
        return item.psName;
      case Lang.ur:
        return item.urName;
    }
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsForAppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.white,
          onPrimary: Colors.black,
          primaryContainer: Colors.white,
          onPrimaryContainer: Colors.black,
          primaryFixed: Colors.white,
          primaryFixedDim: Colors.white70,
          onPrimaryFixed: Colors.black,
          onPrimaryFixedVariant: Colors.black54,
          secondary: Colors.white,
          onSecondary: Colors.black,
          secondaryContainer: Colors.white,
          onSecondaryContainer: Colors.black,
          secondaryFixed: Colors.white,
          secondaryFixedDim: Colors.white70,
          onSecondaryFixed: Colors.black,
          onSecondaryFixedVariant: Colors.black54,
          tertiary: Colors.white,
          onTertiary: Colors.black,
          tertiaryContainer: Colors.white,
          onTertiaryContainer: Colors.black,
          tertiaryFixed: Colors.white,
          tertiaryFixedDim: Colors.white70,
          onTertiaryFixed: Colors.black,
          onTertiaryFixedVariant: Colors.black54,
          error: Colors.red,
          onError: Colors.white,
          errorContainer: Colors.redAccent,
          onErrorContainer: Colors.white,
          outline: Colors.grey,
          outlineVariant: Colors.grey,
          surface: Colors.white,
          onSurface: Colors.black,
          surfaceDim: Colors.white70,
          surfaceBright: Colors.white,
          surfaceContainerLowest: Colors.white,
          surfaceContainerLow: Colors.white,
          surfaceContainer: Colors.white,
          surfaceContainerHigh: Colors.white,
          surfaceContainerHighest: Colors.white,
          onSurfaceVariant: Colors.black54,
          inverseSurface: Colors.black,
          onInverseSurface: Colors.white,
          inversePrimary: Colors.black,
          shadow: Colors.black26,
          scrim: Colors.black12,
          surfaceTint: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsForAppProvider>();
    final settingsNotifier = context.read<SettingsForAppProvider>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0, // Increased height for better visibility
        title: Text(
          settings.getLocalizedText('Settings', 'تنظیمات', 'سیٹنگز'),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSquareButton(
                text: 'Pashto',
                enabled: settings.language == Lang.ps,
                onPressed: () {
                  settingsNotifier.switchLanguage(Lang.ps);
                },
              ),
              const SizedBox(width: 20),
              CustomSquareButton(
                text: 'Urdu',
                enabled: settings.language == Lang.ur,
                onPressed: () {
                  settingsNotifier.switchLanguage(Lang.ur);
                },
              ),
            ],
          ),
          const SizedBox(width: 20, height: 10),
          CustomSquareButton(
            text: 'English',
            enabled: settings.language == Lang.en,
            onPressed: () {
              settingsNotifier.switchLanguage(Lang.en);
            },
          ),
          const SizedBox(height: 50),
          CustomSquareButton(
            text:
                settings.voiceOn
                    ? settings.getLocalizedText('Voice On', 'غږ بل', 'آواز آن')
                    : settings.getLocalizedText(
                      'Voice Off',
                      'غږ بند',
                      'آواز آف',
                    ),
            enabled: settings.voiceOn,
            icon: Icon(
              settings.voiceOn ? Icons.volume_up : Icons.volume_off,
              size: 50, // Increased icon size for better visibility
            ),
            onPressed: () {
              settingsNotifier.toggleVoice();
            },
            size: 120.0, // Increased size for better visibility
          ),
          const SizedBox(height: 50),
          //animated next button:
          SexyCustomNextButton(
            onPressed: () {
              //Use smooth right to left transition to navigate to the main screen
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder:
                      (context, animation, secondaryAnimation) =>
                          const MainScreen(),
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

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//Main screen:
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsForAppProvider>();
    final settingsNotifier = context.read<SettingsForAppProvider>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0,
        title: Text(
          settings.getLocalizedText('Main Screen', 'اصلي پاڼه', 'مین سکرین'),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.3,
              child: CustomTallCategoryButton(
                text:
                    settings.voiceOn
                        ? settings.getLocalizedText(
                          'Education',
                          'زده کړه',
                          'تعلیم',
                        )
                        : '',
                imagePath: 'assets/images/edu.png',
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              const EducationScreen(),
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

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.3,
              child: CustomTallCategoryButton(
                text:
                    settings.voiceOn
                        ? settings.getLocalizedText(
                          'Agriculture',
                          'کرنه',
                          'زراعت',
                        )
                        : '',
                imagePath: 'assets/images/agri.png',
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              const AgriScreen(),
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

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.3,
              child: CustomTallCategoryButton(
                text:
                    settings.voiceOn
                        ? settings.getLocalizedText('Health', 'روغتیا', 'صحت')
                        : '',
                imagePath: 'assets/images/health.png',
                onPressed: () {
                  //navigate to health screen using a smooth right to left transition
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              const HealthScreen(),
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

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1.3,
              child: CustomTallCategoryButton(
                text:
                    settings.voiceOn
                        ? settings.getLocalizedText(
                          'E-commerce',
                          'بازار',
                          'تجارت',
                        )
                        : '',
                imagePath: 'assets/images/ecom.png',
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              const EcomScreen(),
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

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
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

// a simple education screen with a youtube video player:  https://www.youtube.com/watch?v=YMx8Bbev6T4

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsForAppProvider>();
    final settingsNotifier = context.read<SettingsForAppProvider>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0,
        title: Text(
          settings.getLocalizedText('Education', 'زده کړه', 'تعلیم'),
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
        child: Column(
          children: [
            const YoutubeVideoPlayer(
              youtubeUrl: 'https://www.youtube.com/watch?v=YMx8Bbev6T4',
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                settings.getLocalizedText(
                  'This is a simple education screen with a youtube video player. You can add more content here.',
                  'دا د یوټیوب ویډیو پلیر سره د زده کړې ساده پاڼه دی. تاسو کولی شئ دلته نور مطالب اضافه کړئ.',
                  'یہ یوٹیوب ویڈیو پلیئر کے ساتھ ایک سادہ تعلیمی سکرین ہے۔ آپ یہاں مزید مواد شامل کر سکتے ہیں۔',
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//youtube player widget:
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
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;
  late String _videoId;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl) ?? '';
    _initializeController();
  }

  void _initializeController() {
    _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: YoutubePlayerFlags(
        autoPlay: widget.shouldPlay,
        mute: false,
        disableDragSeek: false,
        loop: false,
        enableCaption: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.optionalHeight,
      width: MediaQuery.of(context).size.width - 30,
      // color: Colors.black,
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          progressColors: const ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.redAccent,
          ),
          onReady: () {
            setState(() {
              _isPlayerReady = true;
            });
          },
        ),
        builder: (context, player) {
          return Column(
            children: [
              player,
              if (_isPlayerReady)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _controller.metadata.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                          setState(() {});
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.fullscreen, color: Colors.white),
                        onPressed: () => _controller.toggleFullScreenMode(),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
