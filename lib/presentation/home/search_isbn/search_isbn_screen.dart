import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/presentation/home/book_screen.dart';
import 'package:flutter_project/presentation/home/search_isbn/cubit/search_isbn_cubit.dart';
import 'package:flutter_project/presentation/home/search_isbn/mixin/search_isbn_mixin.dart';
import 'package:flutter_project/utility/show_snack_bar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class SearchIsbnScreen extends StatefulWidget {
  const SearchIsbnScreen({super.key});

  @override
  State<SearchIsbnScreen> createState() => _SearchIsbnScreenState();
}

class _SearchIsbnScreenState extends State<SearchIsbnScreen>
    with _PageProperties, SearchIsbnMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchIsbnViewModel,
      child: Scaffold(body: _buildQrView(context)),
    );
  }

  Widget _buildQrView(BuildContext context) {
    double scanArea = MediaQuery.of(context).size.width * 0.85;
    return BlocConsumer<SearchIsbnCubit, SearchIsbnState>(
      listener: (context, state) {
        if (state is SearchIsbnDisplay) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookScreen(
                  bookModel: state.book,
                ),
              ));
        }
         else if (state is SearchIsbnError) {
          showSnackBar(context: context, text: state.message);
        }
      },
      builder: (context, state) {
        return QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 20,
            borderWidth: 10,
            cutOutSize: scanArea,
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        );
      },
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      try {
        listenerIndex++;
        if (scanData.code != null && scanData.code!.isNotEmpty) {
          if (listenerIndex == 1) {
           searchIsbnViewModel.query(isbn: "9789750718533");

            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return WareHouseReceiptDeliveryView(scannedBarcode: scanData.code!);
            //     },
            //   ),
            // );
          }
        }
      } catch (e) {
        if (listenerIndex == 1) {
          listenerIndex = 0;
          showSnackBar(context: context, text: e.toString());
        }
      }
    });
  }

  void _onPermissionSet(
      BuildContext context, QRViewController controller, bool permission) {
    if (!permission) {
      listenerIndex = 0;

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

mixin _PageProperties {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  int listenerIndex = 0;
}
