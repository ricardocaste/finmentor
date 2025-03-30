import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String message;
  final String timeAgo;
  final IconData icon;

  NotificationItem({
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.icon,
  });
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Account Activity',
      message: 'New transaction: \$235 deposited.',
      timeAgo: '5m',
      icon: Icons.account_balance_wallet,
    ),
    NotificationItem(
      title: 'Market Insights',
      message: 'Global market trends indicate cautious optimism for tech stocks.',
      timeAgo: '1h',
      icon: Icons.analytics,
    ),
    NotificationItem(
      title: 'Crypto Market Update',
      message: 'Bitcoin holds steady; Ethereum sees minor gains.',
      timeAgo: '2h',
      icon: Icons.currency_bitcoin,
    ),
    NotificationItem(
      title: 'Investment News',
      message: 'AI investment firm partners with several cutting-edge tech startups',
      timeAgo: '4h',
      icon: Icons.trending_up,
    ),
    NotificationItem(
      title: 'Regulatory Update',
      message: 'New regulations proposed for digital asset exchanges in EU.',
      timeAgo: '6h',
      icon: Icons.security,
    ),
    NotificationItem(
      title: 'Market Forecast',
      message: 'Analyst anticipates stable growth for renewable energy sector.',
      timeAgo: '8h',
      icon: Icons.show_chart,
    ),
    NotificationItem(
      title: 'Currency Watch',
      message: 'USD strengthens against EUR; AUD remains volatile.',
      timeAgo: '1d',
      icon: Icons.attach_money,
    ),
    NotificationItem(
      title: 'Crypto Airdrop',
      message: 'Participate in upcoming airdrops for new DeFi protocols.',
      timeAgo: '1d',
      icon: Icons.card_giftcard,
    ),
    NotificationItem(
      title: 'Alert: Portfolio Watchlist',
      message: 'Stocks in your watchlist moved over 10% today. Check it out.',
      timeAgo: '2d',
      icon: Icons.visibility,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(onTap: () => Navigator.of(context).pushNamed('detail'),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                notification.icon,
                color: Theme.of(context).primaryColor,
              ),
            ),
            title: Text(
              notification.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              notification.message,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            trailing: Text(
              notification.timeAgo,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          );
        },
      ),
    );
  }
}
