import 'package:flutter/material.dart';
import '../../../models/company.dart';
import '../companies_mypage/audition_register.dart';
import '../companies_mypage/company_info_page.dart';
import '../companies_mypage/company_info_revise.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Company currentCompany;

  @override
  void initState() {
    super.initState();
    currentCompany = sampleCompanies[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: _buildCompanyProfileSection(),
              ),
            ),
            _buildSectionTitle('오디션 관리'),
            _buildListItem('오디션 공고 등록하기'),
            _buildListItem('오디션 공고 보기'),
            _buildSectionTitle('캐스팅 관리'),
            _buildListItem('캐스팅 메시지 관리'),
            _buildListItem('캐스팅한 지원자 보기'),
            _buildSectionTitle('설정'),
            _buildListItem('시스템 설정'),
            _buildListItem('문의하기'),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyProfileSection() {
    return GestureDetector(
      onTap: () => _navigateToCompanyInfo(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: 220,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Stack(
              children: [
                Image.asset(
                  currentCompany.imagePath,
                  width: constraints.maxWidth,
                  height: 234,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '기업정보',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _navigateToCompanyRevise(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                '수정하기',
                                style: TextStyle(
                                  color: Color(0xFF878787),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        currentCompany.company,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${currentCompany.industry} · ${currentCompany.location}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF878787),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          currentCompany.isRecruiting ? '모집 중' : '모집 전',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToCompanyInfo() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompanyInfoPage(company: currentCompany),
      ),
    );

    if (result != null && result is Company) {
      setState(() {
        currentCompany = result;
      });
    }
  }

  void _navigateToCompanyRevise() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompanyInfoRevisePage(company: currentCompany),
      ),
    );

    if (result != null && result is Company) {
      setState(() {
        currentCompany = result;
      });
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF434343),
        ),
      ),
    );
  }

  Widget _buildListItem(String title) {
    return GestureDetector(
      onTap: () {
        if (title == '오디션 공고 등록하기') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AuditionRegisterPage(company: currentCompany),
            ),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFF4F4F5)),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF434343),
          ),
        ),
      ),
    );
  }
}
