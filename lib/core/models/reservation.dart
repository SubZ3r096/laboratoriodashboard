import 'package:flutter/material.dart';

enum ReservationStatus { pendiente, confirmada, cancelada, completada }

class Reservation {
  final String id;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final DateTime date;
  final TimeOfDay time;
  final int numberOfGuests;
  final String tableNumber;
  final ReservationStatus status;
  final String? specialRequests;

  Reservation({
    required this.id,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.date,
    required this.time,
    required this.numberOfGuests,
    required this.tableNumber,
    required this.status,
    this.specialRequests,
  });

  String get statusLabel {
    switch (status) {
      case ReservationStatus.pendiente:
        return 'Pendiente';
      case ReservationStatus.confirmada:
        return 'Confirmada';
      case ReservationStatus.cancelada:
        return 'Cancelada';
      case ReservationStatus.completada:
        return 'Completada';
    }
  }

  String get timeFormatted {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
