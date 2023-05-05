import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

/// NfcScanner is responsible for NFC functionality
class NfcScanner {
  // Method for reading NFC tag

  Future<String?> readNfcTag() async {
    // reset result for each scan
    var result = "";
    // Get the NFC tag id
    try {
      // Check if NFC is available on current device
      var available = await FlutterNfcKit.nfcAvailability;
      if (available != NFCAvailability.available) {
        return "NFC is not available";
      }
      // Start polling for NFC tag
      final tag = await FlutterNfcKit.poll();

      // Set the alert message for iOS
      if (Device.get().isIos) {
        await FlutterNfcKit.setIosAlertMessage("Working on it...");
      }

      // Check for tag type
      if (tag.type == NFCTagType.mifare_ultralight ||
          tag.type == NFCTagType.mifare_classic) {
        var ndefRecords = await FlutterNfcKit.readNDEFRecords();

        // Loop for getting the last element of the sting read from the NFC tag
        for (var element in ndefRecords) {
          var s = element.toString();
          var str = s.split(' ');
          var lstr = str[str.length - 1];
          var res = lstr.split('=');
          // Set the result to the last element of the string
          result = res[1];
          // Set the alert message for iOS omly
          if (Device.get().isIos) {
            await FlutterNfcKit.finish(iosAlertMessage: "Success");
          }
        }
      }

      return result;
    } catch (e) {
      // Set the alert message for iOS
      if (Device.get().isIos) {
        await FlutterNfcKit.finish(iosErrorMessage: "Failed");
      }
      return null;
    }
  }

  Future<bool> isNFCAvailable() async =>
      await FlutterNfcKit.nfcAvailability == NFCAvailability.available;
}
