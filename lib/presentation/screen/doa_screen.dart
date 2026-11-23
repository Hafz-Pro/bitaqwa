import 'package:flutter/material.dart';
import 'package:bitaqwa/data/kategori_doa_data.dart';
import 'package:bitaqwa/extention/kategori_doa_ext.dart';
import 'package:bitaqwa/presentation/widget/card_doa.dart';
import 'package:bitaqwa/presentation/screen/doa_list_screen.dart';
import 'package:bitaqwa/util/color_constant.dart';

class DoaScreen extends StatelessWidget {
  const DoaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FC),
      appBar: AppBar(
        title: const Text('Doa-doa'),
        centerTitle: true,
        backgroundColor: ColorConstant.colorPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: doaCategoryData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 18,
            childAspectRatio: 0.88,
          ),
          itemBuilder: (context, index) {
            final item = doaCategoryData[index];
            final category = item.category;
            return CardDoa(
              image: category.image,
              title: category.title,
              icon: category.icon,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DoaListScreen(category: category),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
