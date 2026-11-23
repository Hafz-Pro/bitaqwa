import 'package:flutter/material.dart';
import 'package:bitaqwa/data/dummy/doa_data.dart';
import 'package:bitaqwa/enum/kategori_doa_enum.dart';
import 'package:bitaqwa/extention/kategori_doa_ext.dart';
import 'package:bitaqwa/presentation/screen/detail_doa_screen.dart';
import 'package:bitaqwa/util/color_constant.dart';

class DoaListScreen extends StatelessWidget {
  final DoaCategory category;

  const DoaListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final doaList = doaData[category] ?? [];

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(category.title),
        centerTitle: true,
        backgroundColor: ColorConstant.colorPrimary,
        foregroundColor: Colors.white,
      ),
      body: doaList.isEmpty
          ? const Center(child: Text('Belum ada doa pada kategori ini.'))
          : ListView.builder(
              itemCount: doaList.length,
              itemBuilder: (context, index) {
                final doa = doaList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 9,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: ColorConstant.colorWhite,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        doa.image,
                        width: 46,
                        height: 46,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.menu_book_rounded,
                          size: 36,
                          color: ColorConstant.colorSecondary,
                        ),
                      ),
                      title: Text(
                        doa.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailDoaScreen(
                              title: doa.title,
                              arabicText: doa.arabicText,
                              translation: doa.translation,
                              reference: doa.reference,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
