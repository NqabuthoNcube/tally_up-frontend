import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/flow/app_flow_state.dart';
import '../../core/flow/flow_controller.dart';

class ScanScreen extends ConsumerWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Scan QR"),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(flowProvider.notifier)
                .goTo(AppFlowState.home);
          },
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              ref.read(flowProvider.notifier)
                  .goTo(AppFlowState.home);
            },
          )
        ],
      ),

      body: Stack(
        children: [

          /// CAMERA VIEW
          MobileScanner(

            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
              facing: CameraFacing.back,
            ),

            onDetect:             
            (barcode) {
              final String? code = barcode.rawValue;
            
              if (code != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Scanned: $code")),
                );
            
                /// Example flow action
                ref.read(flowProvider.notifier).goTo(AppFlowState.sendRecipient);
              }
            }
          ),

          /// SCAN OVERLAY
          Center(
            child: Container(
              width: 250,
              height: 250,

              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on BarcodeCapture {
  String? get rawValue => null;
}