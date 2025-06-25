import 'dart:io';

import 'package:bestforming_cac/core/constants/colours.dart';
import 'package:bestforming_cac/core/constants/fonts.dart';
import 'package:bestforming_cac/core/constants/strings.dart';
import 'package:bestforming_cac/src/shared/widgets/ai_1st_button.dart';
import 'package:bestforming_cac/src/shared/widgets/ai_1st_textview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadCertificateScreen extends StatefulWidget {
  const DownloadCertificateScreen({super.key});

  @override
  State<DownloadCertificateScreen> createState() =>
      _DownloadCertificateScreenState();
}

class _DownloadCertificateScreenState extends State<DownloadCertificateScreen> {
  File? _kDocPath;
  String _kDocUrl = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
      setState(() {
        _kDocUrl = arguments?['url'] ?? '';
        downloadPDF(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.getColor(context).bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.getColor(context).bgColor,
        title: AI1stTextView(
          text: Strings.certificate,
          fontFamily: Fonts.futuraNowHeadlineBold,
        ),
        centerTitle: false,
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0),
            color: AppColors.getColor(context).colorWhite,
            child: Center(
              child: _kDocPath != null
                  ? PDFView(
                      filePath: _kDocPath?.path ?? '',
                    )
                  : CupertinoActivityIndicator(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 20.0),
          child: AI1stButton(
            text: Strings.download,
            onTap: () {
              _launchUrl(_kDocUrl);
            },
          ),
        ),
      ],
    );
  }

  Future<void> downloadPDF(BuildContext context) async {
    final dio = Dio();
    if (!_kDocUrl.contains('https')) {
      _kDocUrl = 'https://$_kDocUrl';
    }
    await dio
        .get(_kDocUrl, options: Options(responseType: ResponseType.bytes))
        .then(
      (value) async {
        final bytes = value.data;
        final directory = (await getApplicationDocumentsDirectory()).path;
        _kDocPath = await File('$directory/quote.pdf').create();
        await _kDocPath?.writeAsBytes(bytes);
        setState(() {});
      },
    );
  }

  Future<void> _launchUrl(url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
