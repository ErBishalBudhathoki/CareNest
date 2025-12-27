import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

class PricingAnalyticsView extends StatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String organizationName;

  const PricingAnalyticsView({
    super.key,
    required this.adminEmail,
    required this.organizationId,
    required this.organizationName,
  });

  @override
  _PricingAnalyticsViewState createState() => _PricingAnalyticsViewState();
}

class _PricingAnalyticsViewState extends State<PricingAnalyticsView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final String _selectedPeriod = 'Last 30 Days';
  String _selectedMetric = 'Revenue';
  final bool _isLoading = false;

  // Mock analytics data
  final Map<String, dynamic> _analyticsData = {
    'revenue': {
      'total': 125000.0,
      'change': 12.5,
      'trend': 'up',
      'data': [85000, 92000, 88000, 95000, 102000, 108000, 125000],
    },
    'averageRate': {
      'total': 85.50,
      'change': -2.3,
      'trend': 'down',
      'data': [87.2, 86.8, 87.5, 86.2, 85.9, 85.1, 85.5],
    },
    'utilizationRate': {
      'total': 78.5,
      'change': 5.2,
      'trend': 'up',
      'data': [72, 74, 76, 75, 77, 79, 78.5],
    },
    'profitMargin': {
      'total': 23.8,
      'change': 1.8,
      'trend': 'up',
      'data': [21.5, 22.1, 21.8, 22.5, 23.2, 23.5, 23.8],
    },
  };

  final List<Map<String, dynamic>> _topServices = [
    {
      'name': 'Support Worker Level 2',
      'code': 'SW_L2',
      'revenue': 45000.0,
      'hours': 520,
      'rate': 86.54,
      'change': 8.2,
    },
    {
      'name': 'Community Participation',
      'code': 'CP_001',
      'revenue': 32000.0,
      'hours': 380,
      'rate': 84.21,
      'change': -2.1,
    },
    {
      'name': 'Personal Care',
      'code': 'PC_001',
      'revenue': 28000.0,
      'hours': 340,
      'rate': 82.35,
      'change': 5.5,
    },
    {
      'name': 'Transport Services',
      'code': 'TS_001',
      'revenue': 20000.0,
      'hours': 250,
      'rate': 80.00,
      'change': 12.3,
    },
  ];

  final List<Map<String, dynamic>> _pricingTrends = [
    {
      'category': 'NDIS Core Supports',
      'averageRate': 85.20,
      'change': 3.2,
      'volume': 1250,
      'trend': 'Increasing',
    },
    {
      'category': 'Capacity Building',
      'averageRate': 92.50,
      'change': -1.5,
      'volume': 890,
      'trend': 'Stable',
    },
    {
      'category': 'Capital Supports',
      'averageRate': 78.90,
      'change': 8.7,
      'volume': 450,
      'trend': 'Increasing',
    },
    {
      'category': 'Transport',
      'averageRate': 65.30,
      'change': 2.1,
      'volume': 320,
      'trend': 'Stable',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildModernHeader(),
          _buildHorizontalStats(),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildModernHeader() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                  ),
                  color: const Color(0xFF475569),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pricing Analytics',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Monitor pricing performance and analyze trends across your services',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Live Data',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalStats() {
    return Container(
      height: 145,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: 'Total Revenue',
                value: '0.125K',
                subtitle: '+12.5% this month',
                icon: Icons.attach_money,
                color: const Color(0xFF6366F1),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: 'Avg Rate',
                value: '\$85.50',
                subtitle: '-2.3% vs last month',
                icon: Icons.trending_down,
                color: const Color(0xFFEF4444),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: 'Utilization',
                value: '78.5%',
                subtitle: '+5.2% improvement',
                icon: Icons.trending_up,
                color: const Color(0xFF10B981),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: 'Profit Margin',
                value: '23.8%',
                subtitle: '+1.8% growth',
                icon: Icons.pie_chart,
                color: const Color(0xFF3B82F6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.more_vert,
                color: Colors.grey[400],
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildKPICards() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildKPICard(
                  'Total Revenue',
                  '\$${(_analyticsData['revenue']['total'] as double).toStringAsFixed(0)}',
                  '${_analyticsData['revenue']['change']}%',
                  _analyticsData['revenue']['trend'] == 'up',
                  Icons.attach_money,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildKPICard(
                  'Avg Rate',
                  '\$${(_analyticsData['averageRate']['total'] as double).toStringAsFixed(2)}',
                  '${_analyticsData['averageRate']['change']}%',
                  _analyticsData['averageRate']['trend'] == 'up',
                  Icons.trending_up,
                  Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildKPICard(
                  'Utilization',
                  '${(_analyticsData['utilizationRate']['total'] as double).toStringAsFixed(1)}%',
                  '${_analyticsData['utilizationRate']['change']}%',
                  _analyticsData['utilizationRate']['trend'] == 'up',
                  Icons.schedule,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildKPICard(
                  'Profit Margin',
                  '${(_analyticsData['profitMargin']['total'] as double).toStringAsFixed(1)}%',
                  '${_analyticsData['profitMargin']['change']}%',
                  _analyticsData['profitMargin']['trend'] == 'up',
                  Icons.pie_chart,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildKPICard(
    String title,
    String value,
    String change,
    bool isPositive,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      (isPositive ? Colors.green : Colors.red).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 12,
                      color: isPositive ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      change,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildRevenueAnalysisTab(),
          _buildServicePerformanceTab(),
          _buildTrendsAndForecastsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Analytics Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildChartPlaceholder(
              'Revenue Trend',
              'Line chart showing revenue over time',
              Icons.show_chart,
              Colors.green,
            ),
            const SizedBox(height: 16),
            _buildChartPlaceholder(
              'Service Distribution',
              'Pie chart showing service revenue distribution',
              Icons.pie_chart,
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildQuickInsights(),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueAnalysisTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Revenue Analysis',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: _selectedMetric,
                  items: ['Revenue', 'Hours', 'Rate', 'Margin']
                      .map((metric) => DropdownMenuItem(
                            value: metric,
                            child: Text(metric),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMetric = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildChartPlaceholder(
              'Revenue by Period',
              'Bar chart showing revenue breakdown by selected period',
              Icons.bar_chart,
              Colors.green,
            ),
            const SizedBox(height: 16),
            _buildChartPlaceholder(
              'Revenue by Service Category',
              'Horizontal bar chart showing revenue by service category',
              Icons.horizontal_split,
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildRevenueBreakdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildServicePerformanceTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Performing Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _topServices.length,
              itemBuilder: (context, index) {
                final service = _topServices[index];
                return _buildServicePerformanceCard(service, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendsAndForecastsTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pricing Trends by Category',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _pricingTrends.length,
              itemBuilder: (context, index) {
                final trend = _pricingTrends[index];
                return _buildTrendCard(trend, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicePerformanceCard(Map<String, dynamic> service, int index) {
    final isPositive = service['change'] > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Code: ${service['code']}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      (isPositive ? Colors.green : Colors.red).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 12,
                      color: isPositive ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${service['change'].abs()}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildServiceMetric(
                  'Revenue',
                  '\$${service['revenue'].toStringAsFixed(0)}',
                  Icons.attach_money,
                  Colors.green,
                ),
              ),
              Expanded(
                child: _buildServiceMetric(
                  'Hours',
                  '${service['hours']}',
                  Icons.schedule,
                  Colors.blue,
                ),
              ),
              Expanded(
                child: _buildServiceMetric(
                  'Rate',
                  '\$${service['rate'].toStringAsFixed(2)}',
                  Icons.trending_up,
                  Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.3, end: 0);
  }

  Widget _buildServiceMetric(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendCard(Map<String, dynamic> trend, int index) {
    final trendColor = trend['trend'] == 'Increasing'
        ? Colors.green
        : trend['trend'] == 'Decreasing'
            ? Colors.red
            : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  trend['category'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: trendColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  trend['trend'],
                  style: TextStyle(
                    color: trendColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Average Rate',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '\$${trend['averageRate'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Change',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${trend['change'] > 0 ? '+' : ''}${trend['change']}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: trend['change'] > 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Volume',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${trend['volume']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn().slideY(begin: 0.3, end: 0);
  }

  Widget _buildChartPlaceholder(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: color),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInsights() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.blue[600]),
              const SizedBox(width: 8),
              Text(
                'Quick Insights',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInsightItem(
            '• Revenue increased by 12.5% compared to last period',
          ),
          _buildInsightItem(
            '• Support Worker Level 2 is the top revenue generator',
          ),
          _buildInsightItem(
            '• Average service rate decreased by 2.3% - consider rate review',
          ),
          _buildInsightItem(
            '• Utilization rate improved by 5.2% - good efficiency trend',
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue[700],
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildRevenueBreakdown() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Revenue Breakdown',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green[800],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildBreakdownItem('NDIS Core', '\$75,000', '60%'),
              ),
              Expanded(
                child:
                    _buildBreakdownItem('Capacity Building', '\$30,000', '24%'),
              ),
              Expanded(
                child: _buildBreakdownItem('Other', '\$20,000', '16%'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownItem(String label, String amount, String percentage) {
    return Column(
      children: [
        Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.green[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.green[600],
          ),
        ),
        Text(
          percentage,
          style: TextStyle(
            fontSize: 11,
            color: Colors.green[500],
          ),
        ),
      ],
    );
  }
}
