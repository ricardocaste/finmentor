import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finmentor/presentation/bloc/trophies/trophies_cubit.dart';
import 'package:finmentor/domain/models/user.dart' as u;


class TrophiesPage extends StatefulWidget {
  const TrophiesPage({super.key, required this.trophiesCubit});

  final TrophiesCubit trophiesCubit;

  @override
  State<TrophiesPage> createState() => TrophiesPageState();
}

class TrophiesPageState extends State<TrophiesPage> {
  

  final int listLength = 7;
  var isSwitched = false;
  u.User? user;

  @override
  void initState() {
    super.initState();
    try {
      _getVersion();
      user = Get.find<u.User>(tag: 'user'); 
    } catch (e) {
      user = null;
    }
  }

  Future<void> _getVersion() async {
    // final packageInfo = await PackageInfo.fromPlatform();
    // setState(() {
    //   _version = packageInfo.version;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Trophies',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            const Text(
              'Your NFTs',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Learn about diversify your holdings for managing investment risk and building long-term wealth.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            
            // Grid de NFTs
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1,
              children: [
                _buildNFTCard(
                  image: 'assets/images/nft1.png',
                  title: 'My first notion',
                  isActive: true,
                ),
                _buildNFTCard(
                  image: 'assets/images/nft2.png',
                  title: 'Financial Education I',
                  isActive: true,
                  isSelected: true,
                ),
                _buildNFTCard(
                  image: 'assets/images/nft3.png',
                  title: 'Financial Education II',
                  isActive: true,
                ),
                _buildNFTCard(
                  image: 'assets/images/nft4.png',
                  title: 'Financial Education III',
                  isActive: true,
                ),
                _buildNFTCard(
                  image: 'assets/images/nft5.png',
                  title: 'My first Crypto',
                  isActive: true,
                ),
                _buildNFTCard(
                  image: 'assets/images/nft6.png',
                  title: '************',
                  isActive: false,
                ),
                _buildNFTCard(
                  image: 'assets/images/nft7.png',
                  title: '************',
                  isActive: false,
                ),
                _buildNFTCard(
                  image: 'assets/images/nft8.png',
                  title: '************',
                  isActive: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNFTCard({
    required String image,
    required String title,
    required bool isActive,
    bool isSelected = false,
  }) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: isSelected 
                ? Border.all(color: Colors.blue, width: 2)
                : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                color: isActive ? null : Colors.black.withValues(alpha: .7),
                colorBlendMode: isActive ? null : BlendMode.darken,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Text(
        //   title,
        //   style: TextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w500,
        //     color: isActive ? Colors.black : Colors.grey,
        //   ),
        //   textAlign: TextAlign.center,
        // ),
      ],
    );
  }

 


}

 