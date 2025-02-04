import 'package:flutter/material.dart';
import 'package:iknowmyrights/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeveloperCard extends StatefulWidget {
  final String name;
  final String role;
  final String imageUrl;
  final String githubUrl;
  final String linkedinUrl;

  const DeveloperCard({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.githubUrl,
    required this.linkedinUrl,
  });

  @override
  State<DeveloperCard> createState() => _DeveloperCardState();
}

class _DeveloperCardState extends State<DeveloperCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 24,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isHovered ? Colors.grey.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(widget.imageUrl),
            ),
            const SizedBox(height: 12),
            Text(
              widget.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              widget.role,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.code),
                  onPressed: () async {
                    if (!await launchUrl(Uri.parse(widget.githubUrl))) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('GitHub profili açılamadı')),
                        );
                      }
                    }
                  },
                  tooltip: 'GitHub',
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.work),
                  onPressed: () async {
                    if (!await launchUrl(Uri.parse(widget.linkedinUrl))) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('LinkedIn profili açılamadı')),
                        );
                      }
                    }
                  },
                  tooltip: 'LinkedIn',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.aboutTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.aboutAppTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.aboutAppDescription,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.developersTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: const [
                DeveloperCard(
                  name: 'Alperen Mimaroğlu',
                  role: 'Fullstack Developer',
                  imageUrl: 'assets/images/developer1.jpg',
                  githubUrl: 'https://github.com/alperenmimaroglu',
                  linkedinUrl: 'https://www.linkedin.com/in/alperenmimaroglu/',
                ),
                DeveloperCard(
                  name: 'Emir Sinan Yoldaş',
                  role: 'Frontend Developer',
                  imageUrl: 'assets/images/developer2.jpg',
                  githubUrl: 'https://github.com/emirsinanyolbas',
                  linkedinUrl: 'https://www.linkedin.com/in/emirsinanyolbas/',
                ),
                DeveloperCard(
                  name: 'Eren Ali Koca',
                  role: 'Frontend Developer',
                  imageUrl: 'assets/images/developer3.jpg',
                  githubUrl: 'https://github.com/erenali',
                  linkedinUrl: 'https://www.linkedin.com/in/erenali/',
                ),
                DeveloperCard(
                  name: 'Sidal Gündüz',
                  role: 'Frontend Developer',
                  imageUrl: 'assets/images/developer4.jpg',
                  githubUrl: 'https://github.com/sidalgunduz',
                  linkedinUrl: 'https://www.linkedin.com/in/sidalgunduz/',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 
