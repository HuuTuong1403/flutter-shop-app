import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripeTransactionResponse {
  final String message;
  final bool success;

  StripeTransactionResponse({required this.message, required this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String sceretKey =
      'sk_test_51JBCX0Cv00P3df17VE2DsIsSBQ3GxVP4vq9Q2dKShInqDvYf4l8iDLTvVOZOFDelwK81Gn6QW2fUwPXlwyHeF6b500drqnI7Mo';

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.sceretKey}',
    'Content-type': 'application/x-www-form-urlencoded',
  };

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            'pk_test_51JBCX0Cv00P3df17jdIdGatYAHiVsVu9zKcHG18BnrqO6ccQ1ktV8gVtI9PsVnKzdWAB585XQDhwK0RB9VYogffL00xORiEWqi',
        merchantId: 'test',
        androidPayMode: 'test'));
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    Map<String, dynamic> body = {
      'amount': amount,
      'currency': currency,
    };
    var response = await http
        .post(Uri.parse(paymentApiUrl), headers: headers, body: body)
        .catchError((err) {
      print('$err');
    });
    return jsonDecode(response.body);
  }

  static Future<StripeTransactionResponse> paymentWithNewCard(
      {required String amount, required String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent['client_secret'],
          paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
            message: 'Transaction successfull', success: true);
      } else {
        return StripeTransactionResponse(
            message: 'Transaction failed', success: false);
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return StripeTransactionResponse(
          message: 'Transaction failed: $err', success: false);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }
    return new StripeTransactionResponse(message: message, success: false);
  }
}
