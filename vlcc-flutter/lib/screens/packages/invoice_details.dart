import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlcc/models/package_invoice_listing.dart';
import 'package:vlcc/resources/app_colors.dart';
import 'package:vlcc/resources/dimensions.dart';
import 'package:vlcc/resources/vlcc_theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vlcc/screens/packages/packages.dart';
import 'package:vlcc/widgets/heading_title_text.dart';

class InvoiceDetails extends StatefulWidget {
  final String invoiceID;
  final String packageName;
  final InvoiceDetail invoiceDetail;
  const InvoiceDetails(
      {Key? key,
      required this.invoiceID,
      required this.packageName,
      required this.invoiceDetail})
      : super(key: key);

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  String savePath = '';
  String taskId = '';
  var progress = 0;
  final PackageProvider _packageProvider = PackageProvider();
  String testLink =
      'https://media.istockphoto.com/photos/multicultural-society-picture-id1294445980?s=612x612';

  ReceivePort _receivePort = ReceivePort();
  static downloadingCallBack(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName('downloading');
    sendPort!.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();
    //------------------------------>Flutter downloader code<-------------------------------
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, 'downloading');
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });
    });
    FlutterDownloader.registerCallback(downloadingCallBack);
    // _getFileSize(widget.message.text);
  }

  Future<void> _requestDownload(String link) async {
    final status = await Permission.storage.request();
    // ignore: omit_local_variable_types
    if (status.isGranted) {
      String fileName = link.substring(link.lastIndexOf('/') + 1);
      savePath = await getFilePath(fileName);
      final externalDir = await getExternalStorageDirectory();

      taskId = (await FlutterDownloader.enqueue(
        url: link,
        savedDir: externalDir!.path,
        fileName: fileName,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      ))!;
    }
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir = await getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName';
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: true,
            backgroundColor: AppColors.backgroundColor,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 14),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(PaddingSize.small),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.backBorder),
                        borderRadius: BorderRadius.circular(16)),
                    child: Icon(
                      Icons.keyboard_backspace,
                      size: 24,
                      color: AppColors.profileEnabled,
                    ),
                  ),
                ),
              ],
            ),
            title: Column(
              children: [
                HeadingTitleText(
                  title: 'Invoice details',
                  fontSize: FontSize.extraLarge,
                ),
                HeadingTitleText(
                  title: widget.invoiceID,
                  fontSize: FontSize.small,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey,
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    _launchURL(widget
                        .invoiceDetail.invoiceUrl); // For using web browser
                    // _requestDownload(_invoiceDetail.invoiceUrl); // For Downloading Loacally...
                  },
                  icon: Icon(Icons.downloading_rounded))
            ],
          ),
          body(context),
        ],
      ),
    );
  }

  Widget body(BuildContext context) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(PaddingSize.extraLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingTitleText(
                            fontSize: FontSize.small,
                            fontWeight: FontWeight.w600,
                            title: 'Package name',
                            color: AppColors.grey,
                          ),
                          HeadingTitleText(
                            fontSize: FontSize.large,
                            title: widget.packageName,
                          ),
                          SizedBox(height: 20),
                          HeadingTitleText(
                            fontSize: FontSize.small,
                            fontWeight: FontWeight.w600,
                            title: 'Clinic name',
                            color: AppColors.grey,
                          ),
                          HeadingTitleText(
                              fontSize: FontSize.large,
                              title: widget.invoiceDetail.centerName),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 23.5,
                            horizontal: 8,
                          ),
                          child: Column(
                            children: [
                              HeadingTitleText(
                                fontSize: FontSize.extraSmall,
                                fontWeight: FontWeight.normal,
                                title: 'Amount paid:',
                              ),
                              HeadingTitleText(
                                  fontSize: FontSize.large,
                                  title:
                                      '₹ ${widget.invoiceDetail.invoiceTotalPaidIncTaxAmount}'),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              Divider(
                height: 40,
                color: VlccColor.lightGreyDivider,
              ),
              HeadingTitleText(
                  fontSize: FontSize.heading, title: 'Invoice details'),
              Card(
                color: AppColors.backgroundColor,
                elevation: 0.6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: AppColors.grey.withOpacity(0.3),
                    )),
                child: Column(
                  children: [
                    Column(
                      children: List.generate(
                          widget.invoiceDetail.invoicePModeDtl!.length,
                          (index) => totalListPrice(
                              invoicePaymentModeDetail: widget
                                  .invoiceDetail.invoicePModeDtl![index])),
                    ),
                    Divider(
                      color: VlccColor.lightGreyDivider,
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadingTitleText(
                            fontSize: FontSize.defaultFont,
                            fontWeight: FontWeight.w600,
                            title: 'Total :',
                          ),
                          HeadingTitleText(
                            fontSize: FontSize.defaultFont,
                            fontWeight: FontWeight.w600,
                            title:
                                '₹ ${widget.invoiceDetail.invoiceTotalAmountAfterDiscount}',
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadingTitleText(
                            fontSize: FontSize.defaultFont,
                            color: AppColors.aquaGreen,
                            fontWeight: FontWeight.w600,
                            title: 'Package Discount :',
                          ),
                          HeadingTitleText(
                            color: AppColors.aquaGreen,
                            fontSize: FontSize.defaultFont,
                            fontWeight: FontWeight.w600,
                            title:
                                '(-)  ₹ ${widget.invoiceDetail.invoiceTotalDiscount}',
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      tileColor: AppColors.pistaGreen,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadingTitleText(
                            fontSize: FontSize.defaultFont,
                            fontWeight: FontWeight.w600,
                            title: 'Amount paid :',
                          ),
                          HeadingTitleText(
                            fontSize: FontSize.defaultFont,
                            fontWeight: FontWeight.w600,
                            title:
                                '₹ ${widget.invoiceDetail.invoiceTotalPaidIncTaxAmount}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // TextButton(
              //     onPressed: () {},
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: const [
              //         Icon(Icons.help_center),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text('Need help?'),
              //       ],
              //     ))
            ],
          ),
        ),
      );

  ListTile totalListPrice({required InvoicePModeDtl invoicePaymentModeDetail}) {
    DateTime dateTime =
        DateTime.parse(invoicePaymentModeDetail.invoicePackagePaymentDate);
    String dateString = Jiffy(dateTime).yMMMMd;

    return ListTile(
      title: HeadingTitleText(
        fontSize: FontSize.defaultFont,
        fontWeight: FontWeight.w600,
        title: invoicePaymentModeDetail.invoicePackagePaymentRefNo,
        color: AppColors.grey,
      ),
      subtitle: HeadingTitleText(
        fontSize: FontSize.small,
        fontWeight: FontWeight.normal,
        title: dateString,
        color: AppColors.grey,
      ),
      trailing: HeadingTitleText(
        fontSize: FontSize.defaultFont,
        fontWeight: FontWeight.w600,
        title: '₹ ${invoicePaymentModeDetail.invoicePackagePaymentAmount}',
        color: AppColors.grey,
      ),
    );
  }
}
