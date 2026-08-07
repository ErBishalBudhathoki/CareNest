import 'payment_info.dart';
import 'recurrence_info.dart';

class InvoiceModel {
  final String clientName;
  final String clientEmail;
  final String clientPhone;
  final List<String> clientAddress;
  final String clientBusinessName;
  final List<String> dateList;
  final List<String> startTimeList;
  final List<String> endTimeList;
  final List<String> breakList;
  final List<String> timeList;
  final double totalAmount;
  final String invoiceNumber;
  final List<String>? attachedPhotos;
  final String? photoDescription;

  // New Advanced Billing Fields
  final PaymentInfo? payment;
  final RecurrenceInfo? recurrence;

  InvoiceModel({
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,
    required this.clientAddress,
    required this.clientBusinessName,
    required this.dateList,
    required this.startTimeList,
    required this.endTimeList,
    required this.breakList,
    required this.timeList,
    required this.totalAmount,
    required this.invoiceNumber,
    this.attachedPhotos,
    this.photoDescription,
    this.payment,
    this.recurrence,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      clientName: "${json['clientFirstName']} ${json['clientLastName']}",
      clientEmail: json['clientEmail'] ?? '',
      clientPhone: json['clientPhone'] ?? '',
      clientAddress: [
        json['clientAddress'] ?? '',
        json['clientCity'] ?? '',
        json['clientState'] ?? '',
        json['clientZip'] ?? '',
      ],
      clientBusinessName: json['clientBusinessName'] ?? '',
      dateList: List<String>.from(json['dateList'] ?? []),
      startTimeList: List<String>.from(json['startTimeList'] ?? []),
      endTimeList: List<String>.from(json['endTimeList'] ?? []),
      breakList: List<String>.from(json['breakList'] ?? []),
      timeList: List<String>.from(json['Time'] ?? []),
      totalAmount: (json['financialSummary']?['totalAmount'] ?? 0.0).toDouble(),
      invoiceNumber: json['invoiceNumber'] ?? '',
      attachedPhotos: json['attachedPhotos'] != null
          ? List<String>.from(json['attachedPhotos'])
          : null,
      photoDescription: json['photoDescription'],
      payment: json['payment'] != null
          ? PaymentInfo.fromJson(json['payment'])
          : null,
      recurrence: json['recurrence'] != null
          ? RecurrenceInfo.fromJson(json['recurrence'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientName': clientName,
      'clientEmail': clientEmail,
      'clientPhone': clientPhone,
      'clientAddress': clientAddress,
      'clientBusinessName': clientBusinessName,
      'dateList': dateList,
      'startTimeList': startTimeList,
      'endTimeList': endTimeList,
      'breakList': breakList,
      'timeList': timeList,
      'totalAmount': totalAmount,
      'invoiceNumber': invoiceNumber,
      'attachedPhotos': attachedPhotos,
      'photoDescription': photoDescription,
      'payment': payment?.toJson(),
      'recurrence': recurrence?.toJson(),
    };
  }

  InvoiceModel copyWith({
    String? clientName,
    String? clientEmail,
    String? clientPhone,
    List<String>? clientAddress,
    String? clientBusinessName,
    List<String>? dateList,
    List<String>? startTimeList,
    List<String>? endTimeList,
    List<String>? breakList,
    List<String>? timeList,
    double? totalAmount,
    String? invoiceNumber,
    List<String>? attachedPhotos,
    String? photoDescription,
    PaymentInfo? payment,
    RecurrenceInfo? recurrence,
  }) {
    return InvoiceModel(
      clientName: clientName ?? this.clientName,
      clientEmail: clientEmail ?? this.clientEmail,
      clientPhone: clientPhone ?? this.clientPhone,
      clientAddress: clientAddress ?? this.clientAddress,
      clientBusinessName: clientBusinessName ?? this.clientBusinessName,
      dateList: dateList ?? this.dateList,
      startTimeList: startTimeList ?? this.startTimeList,
      endTimeList: endTimeList ?? this.endTimeList,
      breakList: breakList ?? this.breakList,
      timeList: timeList ?? this.timeList,
      totalAmount: totalAmount ?? this.totalAmount,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      attachedPhotos: attachedPhotos ?? this.attachedPhotos,
      photoDescription: photoDescription ?? this.photoDescription,
      payment: payment ?? this.payment,
      recurrence: recurrence ?? this.recurrence,
    );
  }

  static InvoiceModel empty() {
    return InvoiceModel(
      clientName: '',
      clientEmail: '',
      clientPhone: '',
      clientAddress: [],
      clientBusinessName: '',
      dateList: [],
      startTimeList: [],
      endTimeList: [],
      breakList: [],
      timeList: [],
      totalAmount: 0.0,
      invoiceNumber: '',
      attachedPhotos: null,
      photoDescription: null,
      payment: null,
      recurrence: null,
    );
  }
}
