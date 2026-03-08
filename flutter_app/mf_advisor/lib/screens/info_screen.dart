import 'package:flutter/material.dart';
import 'input_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade700, Colors.blue.shade400],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Icon(Icons.account_balance_wallet, size: 60, color: Colors.white),
                    const SizedBox(height: 12),
                    const Text(
                      'MF Advisor',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Smart Mutual Fund Recommendations',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const InputScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.rocket_launch, color: Colors.blue.shade700),
                            const SizedBox(width: 8),
                            Text(
                              'Get Started',
                              style: TextStyle(fontSize: 18, color: Colors.blue.shade700, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.blue.shade700),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'How It Works',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'We analyze 4 key factors:',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        
                        _buildCompactFactor('1', 'Risk Tolerance', Icons.trending_up, Colors.orange,
                            'Low, Moderate, or High risk appetite'),
                        _buildCompactFactor('2', 'Investment Horizon', Icons.access_time, Colors.blue,
                            'Short-term, medium, or long-term goals'),
                        _buildCompactFactor('3', 'Investment Goals', Icons.flag, Colors.green,
                            'Retirement, wealth, tax saving, etc.'),
                        _buildCompactFactor('4', 'Investment Amount', Icons.currency_rupee, Colors.purple,
                            'Optimal diversification based on budget'),
                        
                        const SizedBox(height: 20),
                        
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue.shade700, Colors.purple.shade600],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Theme(
                            data: ThemeData().copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              title: const Text(
                                'Our Selection Strategy',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                              ),
                              subtitle: const Text(
                                'Tap to learn how we choose funds',
                                style: TextStyle(fontSize: 12, color: Colors.white70),
                              ),
                              leading: const Icon(Icons.psychology, color: Colors.white, size: 28),
                              trailing: const Icon(Icons.expand_more, color: Colors.white),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildStrategySection(
                                        '1. Risk Assessment',
                                        'We match your risk tolerance with appropriate fund categories:',
                                        [
                                          'Low Risk → 70% Debt + 30% Liquid Funds (Capital preservation)',
                                          'Moderate Risk → 50% Hybrid + 30% Debt + 20% Equity (Balanced growth)',
                                          'High Risk → 60% Equity + 25% Mid Cap + 15% Debt (Maximum returns)',
                                        ],
                                        Colors.orange,
                                      ),
                                      const SizedBox(height: 16),
                                      _buildStrategySection(
                                        '2. Time Horizon Analysis',
                                        'Investment duration determines fund selection:',
                                        [
                                          'Short-term (<3 years) → Liquid & Short Duration funds for stability',
                                          'Medium-term (3-5 years) → Balanced allocation for steady growth',
                                          'Long-term (>5 years) → Higher equity exposure for wealth creation',
                                        ],
                                        Colors.blue,
                                      ),
                                      const SizedBox(height: 16),
                                      _buildStrategySection(
                                        '3. Goal-Based Selection',
                                        'Your investment goals shape fund choices:',
                                        [
                                          'Retirement → Long-term equity funds for compounding',
                                          'Tax Saving → ELSS funds with Section 80C benefits',
                                          'Wealth Creation → Growth-oriented equity funds',
                                          'Education/Short-term → Debt & liquid funds for safety',
                                        ],
                                        Colors.green,
                                      ),
                                      const SizedBox(height: 16),
                                      _buildStrategySection(
                                        '4. Dynamic Fund Allocation',
                                        'Number of funds varies based on investment amount (always totals 100%):',
                                        [
                                          '< ₹5,000 → 1 fund (focused approach)',
                                          '₹5,000 - ₹10,000 → 2 funds (basic diversification)',
                                          '₹10,000 - ₹25,000 → 3 funds (balanced portfolio)',
                                          '₹25,000 - ₹50,000 → 4 funds (enhanced diversification)',
                                          '> ₹50,000 → 5+ funds (maximum diversification)',
                                        ],
                                        Colors.purple,
                                      ),
                                      const SizedBox(height: 16),
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.amber.shade50,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: Colors.amber.shade200),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.auto_awesome, color: Colors.amber.shade700, size: 24),
                                            const SizedBox(width: 12),
                                            const Expanded(
                                              child: Text(
                                                'All recommendations use real-time NAV data and historical performance metrics to ensure accuracy.',
                                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue.shade50, Colors.blue.shade100],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.verified_user, color: Colors.blue.shade700, size: 40),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Real-time Data',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Live NAV & verified historical returns',
                                      style: TextStyle(fontSize: 14, color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStrategySection(String title, String description, List<String> points, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.check_circle, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        ...points.map((point) => Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 6),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  point,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildCompactFactor(String number, String title, IconData icon, Color color, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(icon, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
