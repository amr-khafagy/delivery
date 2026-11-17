import 'package:flutter/material.dart';

void main() {
  runApp(const DeliveryDemoApp());
}

class DeliveryDemoApp extends StatelessWidget {
  const DeliveryDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery Driver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF315EFB),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        fontFamily: 'Cairo',
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const OverviewTab(),
      const OrdersTab(),
      const ProfileTab(),
    ];

    return Scaffold(
      body: SafeArea(child: screens[selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => setState(() => selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      children: [
        const _Header(),
        const SizedBox(height: 24),
        const Text(
          "Today's deliveries",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        const _StatsRow(),
        const SizedBox(height: 28),
        const _SectionTitle(title: 'Active delivery', action: 'View all'),
        const SizedBox(height: 12),
        ActiveOrderCard(
          order: demoOrders.first,
          onTrack: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TrackingScreen(order: demoOrders.first),
            ),
          ),
        ),
        const SizedBox(height: 28),
        const _SectionTitle(title: 'Next up', action: '2 orders'),
        const SizedBox(height: 12),
        ...demoOrders.skip(1).map((order) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CompactOrderCard(order: order),
            )),
      ],
    );
  }
}

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      children: [
        const Text('Orders', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        const Text('Manage your delivery queue', style: TextStyle(color: Color(0xFF6D7485))),
        const SizedBox(height: 24),
        ...demoOrders.map((order) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CompactOrderCard(
                order: order,
                onTap: order == demoOrders.first
                    ? () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TrackingScreen(order: order),
                          ),
                        )
                    : null,
              ),
            )),
      ],
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      children: const [
        Text('Profile', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
        SizedBox(height: 24),
        _ProfileCard(),
        SizedBox(height: 20),
        _ProfileSetting(icon: Icons.notifications_outlined, title: 'Delivery notifications'),
        _ProfileSetting(icon: Icons.language_outlined, title: 'Language and region'),
        _ProfileSetting(icon: Icons.help_outline, title: 'Help center'),
      ],
    );
  }
}

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key, required this.order});

  final DeliveryOrder order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live delivery route')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          RoutePreview(order: order),
          const SizedBox(height: 24),
          Text(order.customer, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(order.address, style: const TextStyle(color: Color(0xFF6D7485))),
          const SizedBox(height: 20),
          _DeliveryStep(
            icon: Icons.inventory_2_outlined,
            title: 'Order picked up',
            subtitle: 'Picked up from ${order.store}',
            completed: true,
          ),
          _DeliveryStep(
            icon: Icons.delivery_dining_outlined,
            title: 'Driver is on the way',
            subtitle: 'Estimated arrival in ${order.etaMinutes} minutes',
            completed: true,
          ),
          const _DeliveryStep(
            icon: Icons.flag_outlined,
            title: 'Order delivered',
            subtitle: 'Confirm delivery when you arrive',
            completed: false,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Delivery marked as complete in demo mode.')),
            ),
            icon: const Icon(Icons.check_circle_outline),
            label: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Complete delivery'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xFFE3E9FF),
          child: Icon(Icons.person, color: Color(0xFF315EFB)),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good morning, Amr', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              SizedBox(height: 3),
              Text('Ready for your next delivery?', style: TextStyle(color: Color(0xFF6D7485))),
            ],
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _StatCard(value: '08', label: 'Completed', color: Color(0xFF315EFB))),
        SizedBox(width: 12),
        Expanded(child: _StatCard(value: '03', label: 'In progress', color: Color(0xFFFFA23A))),
        SizedBox(width: 12),
        Expanded(child: _StatCard(value: '4.9', label: 'Rating', color: Color(0xFF29A66A))),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label, required this.color});

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF6D7485))),
        ],
      ),
    );
  }
}

class ActiveOrderCard extends StatelessWidget {
  const ActiveOrderCard({super.key, required this.order, required this.onTrack});

  final DeliveryOrder order;
  final VoidCallback onTrack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF315EFB), Color(0xFF6285FF)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.delivery_dining, color: Colors.white),
              const SizedBox(width: 8),
              const Text('On the way', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const Spacer(),
              Text(order.id, style: const TextStyle(color: Color(0xFFDDE5FF))),
            ],
          ),
          const SizedBox(height: 22),
          Text(order.customer, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 6),
          Text(order.address, style: const TextStyle(color: Color(0xFFDDE5FF))),
          const SizedBox(height: 22),
          Row(
            children: [
              const Icon(Icons.schedule, color: Color(0xFFDDE5FF), size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${order.etaMinutes} min away',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onTrack,
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF315EFB),
              ),
              child: const Text('View live route'),
            ),
          ),
        ],
      ),
    );
  }
}

class CompactOrderCard extends StatelessWidget {
  const CompactOrderCard({super.key, required this.order, this.onTap});

  final DeliveryOrder order;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: order.statusColor.withValues(alpha: 0.12),
          child: Icon(Icons.receipt_long_outlined, color: order.statusColor),
        ),
        title: Text(order.customer, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text('${order.store} - ${order.address}'),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _StatusChip(label: order.status, color: order.statusColor),
            const SizedBox(height: 6),
            Text('${order.etaMinutes} min', style: const TextStyle(fontSize: 12, color: Color(0xFF6D7485))),
          ],
        ),
      ),
    );
  }
}

class RoutePreview extends StatelessWidget {
  const RoutePreview({super.key, required this.order});

  final DeliveryOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(color: const Color(0xFFE8EEFF), borderRadius: BorderRadius.circular(24)),
      child: Stack(
        children: [
          const Positioned.fill(child: CustomPaint(painter: RoutePainter())),
          const Positioned(top: 22, left: 22, child: _MapLabel(icon: Icons.storefront_outlined, label: 'Pickup')),
          const Positioned(right: 22, bottom: 22, child: _MapLabel(icon: Icons.location_on_outlined, label: 'Drop-off')),
          Positioned(
            left: 112,
            top: 125,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: Color(0xFF315EFB), shape: BoxShape.circle),
              child: const Icon(Icons.delivery_dining, color: Colors.white),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 18,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Text('${order.etaMinutes} min to ${order.customer}', style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class RoutePainter extends CustomPainter {
  const RoutePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFFC8D4F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    final routePaint = Paint()
      ..color = const Color(0xFF315EFB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    final road = Path()
      ..moveTo(24, size.height * .30)
      ..quadraticBezierTo(size.width * .40, size.height * .10, size.width * .50, size.height * .44)
      ..quadraticBezierTo(size.width * .68, size.height * .78, size.width - 24, size.height * .55);
    canvas.drawPath(road, roadPaint);
    canvas.drawPath(road, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapLabel extends StatelessWidget {
  const _MapLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 16, color: const Color(0xFF315EFB)), const SizedBox(width: 5), Text(label)],
      ),
    );
  }
}

class _DeliveryStep extends StatelessWidget {
  const _DeliveryStep({required this.icon, required this.title, required this.subtitle, required this.completed});

  final IconData icon;
  final String title;
  final String subtitle;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final color = completed ? const Color(0xFF315EFB) : const Color(0xFFB5BDCD);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withValues(alpha: 0.12), child: Icon(icon, color: color)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(subtitle, style: const TextStyle(color: Color(0xFF6D7485))),
              ],
            ),
          ),
          Icon(completed ? Icons.check_circle : Icons.radio_button_unchecked, color: color),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.action});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        const Spacer(),
        Text(
          action,
          style: const TextStyle(color: Color(0xFF315EFB), fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w700)),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: const Row(
        children: [
          CircleAvatar(radius: 30, backgroundColor: Color(0xFFE3E9FF), child: Icon(Icons.person, size: 34, color: Color(0xFF315EFB))),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Amr Khafagy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              SizedBox(height: 4),
              Text('Delivery partner', style: TextStyle(color: Color(0xFF6D7485))),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileSetting extends StatelessWidget {
  const _ProfileSetting({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF315EFB)),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class DeliveryOrder {
  const DeliveryOrder({
    required this.id,
    required this.customer,
    required this.store,
    required this.address,
    required this.etaMinutes,
    required this.status,
    required this.statusColor,
  });

  final String id;
  final String customer;
  final String store;
  final String address;
  final int etaMinutes;
  final String status;
  final Color statusColor;
}

const demoOrders = [
  DeliveryOrder(
    id: '#DL-3028',
    customer: 'Maya Adel',
    store: 'Fresh Basket',
    address: 'Zayed Square, Giza',
    etaMinutes: 12,
    status: 'On the way',
    statusColor: Color(0xFF315EFB),
  ),
  DeliveryOrder(
    id: '#DL-3031',
    customer: 'Omar Ahmed',
    store: 'Coffee Corner',
    address: 'Smart Village, Giza',
    etaMinutes: 25,
    status: 'Accepted',
    statusColor: Color(0xFFFFA23A),
  ),
  DeliveryOrder(
    id: '#DL-3035',
    customer: 'Sara Youssef',
    store: 'Green Market',
    address: 'Sheikh Zayed, Giza',
    etaMinutes: 38,
    status: 'Pending',
    statusColor: Color(0xFF7A8395),
  ),
];
