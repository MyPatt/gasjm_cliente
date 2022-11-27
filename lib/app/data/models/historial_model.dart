import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class CryptoData {
  static final getData = [
    {
      'name': 'Bitcoin',
      'symbol': 'BTC',
      'icon': Icons.dashboard,
      'iconColor': Colors.orange,
      //'iconColor': AppTheme.blueDark,
      'change': '+3.67%',
      'changeValue': '+202.835',
      'changeColor': Colors.green,
     
     // 'changeColor': AppTheme.blueBackground,
      'value': '\$12.279',
    },
    {
      'name': 'Ethereum',
      'symbol': 'ETH',
      'icon': Icons.meeting_room,
      'iconColor': Colors.green,
      'change': '+5.2%',
      'changeValue': '25.567',
      'changeColor': Colors.green,
      'value': '\$7.809'
    },
  ];
}
