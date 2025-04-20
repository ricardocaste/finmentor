class ApiTerm {
  final String id;
  final String term;
  final String image;
  final String description;
  final String content;
  final String category;
  final String termType;
  final List<String> relationsBetweenTerms;
  final List<String> examples;

  ApiTerm({
    required this.id,
    required this.term,
    required this.image,
    required this.description,
    required this.content,
    required this.category,
    required this.termType,
    required this.relationsBetweenTerms,
    required this.examples,
  });

  factory ApiTerm.fromJson(Map<String, dynamic> json) {
    return ApiTerm(
      id: json['id'] ?? '',
      term: json['term'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      category: json['category'] ?? '',
      termType: json['termType'] ?? '',
      relationsBetweenTerms: List<String>.from(json['relationsBetweenTerms'] ?? []),
      examples: List<String>.from(json['examples'] ?? []),
    );
  }

  // Método para convertir ApiTerm a Term
  Term toTerm() {
    return Term(
      title: term,
      category: category,
      description: description,
      content: content,
      image: image,
    );
  }
}


// {
//             "id": "term-1",
//             "term": "ETF",
//             "image": "https://omi.devfolio.co/_next/image?url=https%3A%2F%2Fassets.devfolio.co%2Fhackathons%2F44a87b7e2f4941c2861458615ca7d9fa%2Fassets%2Ffavicon%2F741.png&w=1440&q=75",
//             "shortDescription": "Fondo cotizado en bolsa",
//             "longDescription": "Un ETF (Exchange-Traded Fund) es un tipo de fondo de inversión que cotiza en bolsa como una acción...",
//             "category": "inversiones",
//             "termType": "web2",
//             "relationsBetweenTerms": [
//                 "fondo indexado",
//                 "comisiones",
//                 "diversificación"
//             ],
//             "examples": [
//                 "SPDR S&P 500 ETF (SPY)",
//                 "iShares MSCI Emerging Markets ETF (EEM)"
//             ]
//         }

class Term {
  final String title;
  final String category;
  final String description;
  final String content;
  final String image;

  Term({
    required this.title,
    required this.category,
    required this.description,
    required this.content,
    required this.image,
  });

  // static final terms = [
  //   Term(
  //     title: 'Omi Token',
  //     category: 'Financial Education',
  //     description: 'The key to unlocking financial freedom in the Omi ecosystem. Earn, trade, and grow your wealth with seamless transactions and exclusive rewards. Your money, your rules.',
  //     content: [
  //       'OMI Token is the backbone of the Omi ecosystem, designed to empower users with seamless financial transactions, rewards, and investment opportunities. Whether you\'re saving, trading, or spending, OMI Token ensures secure and efficient operations while reducing transaction fees. With its integration into various DeFi platforms, users can leverage OMI to participate in staking, governance, and exclusive ecosystem benefits.',
  //       'Beyond transactions, OMI Token represents a step towards decentralized financial independence. By holding and using OMI, users gain access to premium financial services, investment tools, and AI-driven insights to optimize their financial growth. As the ecosystem expands, OMI Token continues to unlock new possibilities, bridging traditional finance with the future of Web3.'
  //     ],
  //     imagePath: 'assets/images/course1.png',
  //   ),
  //   Term(
  //     title: 'Smart Budgeting',
  //     category: 'Investment Tip',
  //     description: 'Take control of your finances with AI-driven budgeting! Track expenses, optimize spending, and reach your savings goals effortlessly. Let your money work for you.',
  //     content: [
  //       'Managing your money shouldn\'t be complicated. With Smart Budgeting, AI-powered insights help you categorize your expenses, track your income, and allocate funds efficiently. Whether you\'re following the 50/30/20 rule or customizing your own budget, our system adapts to your financial goals and spending habits, giving you real-time recommendations to optimize your savings.',
  //       'No more overspending or wondering where your money went—Smart Budgeting keeps you informed and in control. Receive alerts when you exceed your budget, get personalized tips to cut unnecessary expenses, and watch your financial health improve. With automation and AI-driven analysis, saving money becomes effortless, paving the way for financial stability and long-term wealth.'
  //     ],
  //     imagePath: 'assets/images/course2.png',
  //   ),
  //   Term(
  //     title: 'AI-Powered Investing',
  //     category: 'Crypto Insight',
  //     description: 'Invest smarter, not harder! Our AI analyzes market trends to help you diversify and maximize returns. Say goodbye to guesswork and hello to financial growth.',
  //     content: [
  //       'Investing can be overwhelming, but AI makes it simple. AI-Powered Investing analyzes real-time market trends, economic indicators, and your personal risk profile to create a smart, diversified investment strategy. Whether you\'re a beginner or an experienced investor, AI removes the guesswork and helps you make data-driven decisions that maximize your returns while minimizing risk.',
  //       'Gone are the days of emotional trading and uninformed choices. With AI-driven insights, you receive tailored recommendations on stocks, ETFs, crypto, and other assets, ensuring a balanced portfolio. Plus, automated rebalancing keeps your investments aligned with your financial goals. AI-Powered Investing gives you the edge of a professional investor, all at your fingertips.'
  //     ],
  //     imagePath: 'assets/images/course3.png',
  //   ),
  // ];

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      image: json['image'] ?? '',
    );
  }
  
} 