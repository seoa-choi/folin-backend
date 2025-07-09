SET NAMES utf8mb4;

CREATE DATABASE folin_db DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
USE folin_db;


-- linker 분류 탭
CREATE TABLE occupation (
	occupation_id INT AUTO_INCREMENT PRIMARY KEY,
	occupation VARCHAR(50) NOT NULL
);
DESC occupation;

INSERT INTO occupation (occupation) VALUES
('전체'),
('마케터'),
('기획자'),
('디자이너'),
('커리어'),
('콘텐츠'),
('F&B'),
('공간'),
('테크');

SELECT * FROM occupation;


CREATE TABLE linker (
    linker_id INT AUTO_INCREMENT PRIMARY KEY,
    -- 소개 게시글
    comment VARCHAR(255), 
    -- 저자
    author VARCHAR(50) NOT NULL,
    -- 소속
    affiliation VARCHAR(50) NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- 외래키
    occupation_id INT
);
DESC linker;

INSERT INTO linker (comment, author, affiliation, occupation_id) VALUES
('기술자 아닌 해결사가 되세요.', '장인성', '우아한형제들 CBO', 2),
('저는 기획력도 근육이라고 생각해요. 연습이 되면 점점 늘어요.', '신석진/ 크래프톤', '크리에이티브센터 본부장', 3),
('브랜드의 힘은 기업이 자신의 의미를 자각할 때 생겨요.', '전채리', 'CFC스튜디오 대표', 4),
('오래, 건강하게 일하기 위해서는 나의 일을 나만의 언어로 설명할 수 있어야 해요.', '김나이', '커리어 엑셀러레이터', 5),
('결국에는 \'디테일\'이라고 생각합니다. 사용자의 감동은 \'예상하지 못한 작은 배려의 순간\'에 옵니다.', '김승언/ 네이버 글로벌 커뮤니티', '비즈니스 대표', 6),
('메시지 라인업은 책상에 앉아서 하면 안 됩니다. 현장도 가봐야 하고, 고객들이 어떻게 먹는지도 보면서 인사이트를 찾아야 해요.', '강호준', '오뚜기 온라인 비즈니스 총괄', 7),
('지문이나 목소리처럼 브랜드도 고유의 것이 있다 생각해요.', '김재원', '아틀리에애크리튜 대표', 8),
('저희는 한국에서 1등하는 회사에 투자해 본 적은 단 한 번도 없어요.', '류중희', '퓨처플레이 대표', 9),
(NULL, '김서연', '토스증권 UX 리서처', 1),
(NULL, '임철우', '무신사 리테일팀 팀장', 1),
(NULL, '최혜지', '무신사 남성패션팀 팀장', 1),
(NULL, '주세준', '무신사 유니섹스패션팀 팀장', 1),
(NULL, '박민재', '무신사 브랜드개발본부 실장', 1),
(NULL, '남대희', '『미세공격 주의보』저자', 1),
(NULL, '박상예', '스캐터랩 PO, UA Lead', 1),
(NULL, '이승희', '브랜드 마케터', 2),
(NULL, '롯데카드', NULL, 1),
(NULL, '김유림', 'CJ제일제당 햇반팀 팀리드', 1),
(NULL, '정희원', '노년내과 의사', 1),
(NULL, '양정호', '앳홈 대표', 1),
(NULL, '이강원', '오늘의집 엔지니어링 매니저', 9),
(NULL, '박원준', '오늘의집 엔지니어링 매니저', 9),
(NULL, '이승복', '크록스 이커머스 디렉터', 1),
(NULL, '김형준', '마일스톤 커피 대표', 1);

-- 추가
INSERT INTO linker (comment, author, affiliation, occupation_id) VALUES
(NULL, '박상완', 'LG전자 myCup Company 대표', 1),
(NULL, '김미성', 'LG전자 myCup Company 선임연구원', 1),
(NULL, '김민준', 'LG전자 HS공간사업기획팀 선임', 1),
(NULL, '김연지', 'HLL 엔터사업본부 엔터뉴스팀 팀장', 1),
(NULL, '유상선', '한화생명 문화마케팅 팀장', 1),
(NULL, '임재택', '한양증권 대표', 1),
(NULL, '김연정', '파리바게뜨 마케팅본부장', 2),
(NULL, '김윤정', '무신사 글로벌브랜드비즈니스본부 실장', 1),
(NULL, '김한수', 'SM 브랜드마케팅 VX센터 실장', 2),
(NULL, '신해옥', '디자이너', 4),
(NULL, '신동혁', '디자이너', 4),
(NULL, '한현수', '디자이너', 4);

SELECT * FROM linker;

CREATE TABLE linker_details (
	image_url VARCHAR(255) NOT NULL,
    author_info TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- 외래 키
    linker_id INT
);
DESC linker_details;


INSERT INTO linker_details (image_url, author_info, linker_id) VALUES 
('/images/linker/linker_large_jang.png', 
'우아한형제들을 거쳐 스테이폴리오 대표로 일하고 있다. 창의적인 해결책을 만들기 위해서는 머리와 마음을 모으는 협업이 중요하다고 믿고 일하기 좋은 조직문화를 만드는데 애를 쓴다. 『마케터의 일』, 『사는 이유』를 썼다. ', 1),
('/images/linker/linker_large_shin.png', '크리에이티브-광고 전문가로, 현재는 게임사 크래프톤에서 \'PUBG: 배틀그라운드\'를 비롯한 다양한 글로벌 게임 타이틀의 크리에이티브 제작 총괄, 북미&한국의 Creative Center를 리딩하며 글로벌 AAA 수준의 크리에이티브를 제작하고 있다. 최근에는 크래프톤의 버추얼 휴먼 \'애나(ANA)\' 신사업도 총괄하고 있다.

이전에 제일기획에서 글로벌 크리에이티브 디렉터로 글로벌 타깃으로 삼성 갤럭시 모바일 캠페인, 패션 브랜드 FILA의 BTS(K-pop Boy Band) 컬래버레이션 캠페인 등 수많은 글로벌 디지털 캠페인 등을 제작했다. 한국인 최초로 칸 국제 광고제에서 영라이언스(Young Lions)을 수상한 바 있으며, 칸 국제광고제, 원쇼, 뉴욕 페스티벌 등 세계 3대 국제광고제 다수 수상 및 심사위원을 역임하였다. ', 2),
('/images/linker/linker_large_jeon.png', '2013년 브랜드 디자인에 주력하는 스튜디오 CFC(ContentFormContext)를 설립해 아트디렉터 겸 디자이너로 일하고 있다. 마켓컬리, 티빙, SM엔터테인먼트, 아모레퍼시픽, 한섬, 하이브 등 다양한 산업군의 클라이언트와 협업하고 있다. 서울대학교에서 시각디자인을 전공했고, 현재 이화여대 조형예술대학 겸임교수이다. 2022, 2023년 iF 디자인어워드 심사위원을 맡았다.', 3),
('/images/linker/linker_large_kimna.png', '\"4000명 직장인 컨설팅한 커리어 액셀러레이터\"

1년에 300명 이상 커리어를 상담하고 미래 설계를 돕는 인재 개발 전문가다. 현대카드, 한국투자증권, J.P모건 등 금융권에서 일한 경험을 바탕으로 산업과 기업의 최신 동향을 분석해 거시적인 시각에서 개인의 커리어를 설계해준다. <자기만의 트랙>, <이기는 취업>, <쌩초보 ELS, ELW 황금수익률 따라잡기> 등을 썼고, 폴인에서 <당신은 더 좋은 회사를 다닐 자격이 있다 : 나를 성장시키는 이직의 기술> <어차피 하는 일, 재밌게 하고 싶어> 를 연재했다.', 4),
('/images/linker/linker_large_kimseng.png', '서울대 디자인학부를 졸업한 뒤, 2003년부터 네이버(당시 NHN)에 입사해 UX, UI, 브랜딩 디자인 등 다양한 프로젝트에 참여했다. 2006년부터 2007년까지는 실리콘밸리의 NHN USA 미국 법인에서 신규 서비스 런칭 프로젝트를 담당하고, 2008년부터 네이버 브랜딩, 마케팅 조직인 BX실을 맡아서, 네이버의 주요 프로젝트에 참여했다. 2014년부터는 네이버 전체 디자인을 총괄하는 임원으로, 현재까지 네이버 메인, 검색, 네이버앱 등 네이버의 모든 서비스 디자인을 책임지고 있다. 블로그, 지식인, 네이버TV 등 UGC형 서비스와 글로벌 신규 서비스 개발을 담당하는 사내 독립 기업(CIC)의 대표를 맡아 사용자 생산형 콘텐츠 서비스의 다음 세대를 준비했다. 그 후 네이버 글로벌 커뮤니티 비즈니스 대표로 자리를 옮겼다.', 5),
('/images/linker/linker_large_kang.png', '2년의 창업, 17년동안 F&B에서 일했습니다. 기획실에서 가격/영업전략, 수요예측/사업기획, B2B유통전략 등 다양한 업무를 하다가, 온라인비즈니스 조직을 리딩했습니다. 최근 퇴사 후, 유통 관련 스타트업에서 수습사원으로 경험을 쌓고 있습니다. ', 6),
('/images/linker/linker_large_kimjae.png', '자그마치, 오르에르를 거쳐 과자가게 오드 투 스윗, 창작자들을 위한 공간 포인트오브뷰를 만들었다. 자체 브랜드 운영은 물론, 지금은 다양한 외부 프로젝트의 아트디렉션을 하고 있다. 런던 세인트마틴 텍스타일 디자인 전공을 거쳐 건국대 리빙디자인 전공 겸임교수이자 디자인학 박사이다.', 7),
('/images/linker/linker_large_ryu.png', '액셀러레이터 퓨처플레이 대표. 모바일 영상 인식 스타트업 \'올라웍스\'를 창업, 국내 최초로 글로벌 기업인 \'인텔\'에 인수되었다.

2013년 퓨처플레이를 창업해 인류의 문제를 해결하는 스타트업 성장에 함께 하고 있으며, 스타트업 생태계 발전을 위한 \'휴먼 액셀러레이션\' 사업 영역에도 힘쓰고 있다.', 8),
('/images/linker/linker_kimseoyeon.jpg', '첫 커리어를 UX 컨설팅 회사 PXD에서 시작했다. 다양한 클라이언트를 만나본 경험을 살려 2019년 토스에 첫 UX 리서처로 합류했다. 이후 토스증권으로 자리를 옮겨, 토스증권의 제품 전략 및 사용성 전반에서 UX리서치를 주도하고 있다.', 9),
('/images/linker/linker_limchulwoo.jpg', '022년 무신사에 입사해 현재 무신사의 오프라인 스토어 기획 및 사업 개발을 담당하고 있다. 오프라인 기반 패션 편집숍에서 사회 생활을 시작하여, 패션 대기업 하에서 편집숍과 브랜드 사업을 맡으며 패션 오프라인 전문가로서의 경력을 쌓아왔다. ', 10),
('/images/linker/linker_choihyeji.jpg', '2016년 무신사에 합류해 현재는 남성 패션 카테고리의 운영과 관리를 담당하고 있다. 패션 대기업의 온라인 플랫폼에서 MD로 커리어를 시작했으며, 무신사에서는 스토어 기획과 캐주얼 MD 직무를 거쳐왔다.', 11),
('/images/linker/linker_joosejune.jpg', '무신사 플랫폼 오프라인 스토어의 기획 및 사업 개발을 담당하고 있다. 무신사 글로벌/유니섹스 본부 유니섹스팀, 글로벌스토어의 입점사 관리를 담당한다. 작은 벤더 회사에서 커리어를 시작,  MD의 꿈을 키워 2018년 무신사에 입사했다.', 12),
('/images/linker/linker_parkminjae.jpg', '2020년 무신사에 입사해 사업기획 파트장, 영업기획팀장, 커머스전략팀장·실장을 거쳐 현재 무신사 브랜드개발본부 실장으로 일하고 있다. 무신사 인큐베이션 프로그램, 전략 파트너, 성장 파트너 프로그램을 설계하고 운영했다. 무신사 에디션을 론칭했고, 시즌 프리뷰나 트렌드 세미나처럼 브랜드를 지원하는 일들도 했다.', 13),
('/images/linker/linker_namdaehee.png', '30여년간 대기업 임원, 정부 부처 팀장, 언론사 기자를 경험한 전략기획, 커뮤니케이션 전문가. 대기업 임원 시절 다양한 백그라운드를 지닌 직원들의 생각을 알고 싶어 3년간 \'다양성 토크\'를 진행했다.', 14),
('/images/linker/linker_parksanghye.jpg', '온·오프라인을 깊이 구르며 재미 있는 것들을 줍고, 글로 풀어보는 걸 좋아합니다. 유머와 심리학에 진심이라, 차가운 기술이나 서비스에 사람 온기를 불어 넣는 일을 해왔습니다. 딱딱한 걸 말랑하게, 복잡한 걸 단순하게 만드는 걸 좋아해요. 추상적인 것도 마다하지 않지만, 결국 사람에게 닿는 무언가를 만드는 데서 제일 큰 보람을 느낍니다. 기획은 타협 없이, 노동은 즐겁게. 지속가능하게 일하고 싶습니다. ', 15),
('/images/linker/linker_soong.png', '16년 차 마케터이자 기록생활자. 일리노이치과, 우아한형제들, 네이버를 거쳐 현재 그란데클립 마케팅 디렉터로 활동 중이다. 다양한 사람들과 재밌는 일을 도모하고 질문하는 것을 좋아한다. 주요 저서로 『기록의 쓸모』, 「일놀놀일』 , 『별게 다 영감』 , 『질문 있는 사람』 이 있다.', 16),
('/images/linker/linker_digiloca.jpg', NULL, 17),
('/images/linker/linker_KUR.jpg', 'CJ제일제당 글로벌 마케팅 직무로 2011년 입사한 후 국내외 다양한 브랜드 및 제품 운영을 경험하며 회사와 함께 14년차 성장하는 중입니다.

2013년 비비고 브랜드 런칭 및 커뮤니케이션 업무를 거쳐, 신규사업으로 HMR부서에서 죽 신제품을 출시하였으며 2022년부터는 햇반 팀리드로서 소비자 식생활 트렌드에 맞는 \'언제나 맛있는 집밥\'을 선사하기 위해 잡곡밥, 곤약밥, 저속노화밥 등을 출시하며 열정을 쏟고 있습니다.

앞으로도 회사에서는 끊임없이 성장하는 리더로, 가정에서는 두 아들에게 자랑스러운 엄마가 되고자 합니다.', 18),
('/images/linker/linker_JHW.jpg', '교조주의와 프로크루테스의 침대를 싫어하고 호른을 좋아한다. 복잡한 문제 푸는 일을 좋아해서 노인의학을 공부하게 되었고, 지식에 목마름을 느껴 이학박사를 취득했다. 노년내과 의사로 일하며 수많은 노년의 사람들을 만나 다양한 사례를 접한 후 여러 방송에 출연하여 저속노화에 대해 알리기 시작했다.

공부를 하고 논문을 써도 세상이 바뀌지 않아 책을 썼고, 그래도 달라지는 게 없어 사람들에게 하고 싶은 말들을 직접 울부짖는 유튜브 채널 \'정희원의 저속노화\'를 만들어 운영하고 있다. 앞으로도 더 많은 이에게 노인 건강 인식 개선, 노화 예방 등의 중요성을 알리고자 한다.

지은 책으로 『저속노화 식사법』 『느리게 나이 드는 습관』 『당신도 느리게 나이 들 수 있습니다』 『지속가능한 나이듦』 등이 있고, 공저로 『왜 우리는 매일 거대도시로 향하는가』가 있다.', 19),
('/images/linker/linker_yangjingho.png', '2018년 고객이 불편을 느끼고 있지만 누구도 해결하지 않은 \'숨겨진 문제\'를 해결하기 위해 앳홈을 창업했다. \'가전은 대기업만의 영역\'이라는 고정관념을 깨고, 기술·디자인·고객 경험의 전 과정에 진정성을 담은 제품을 선보이며 시장의 판을 흔들고 있다. 국내 1위 음식물처리기 브랜드 \'미닉스\', 프라이빗 에스테틱이라는 새로운 시장을 연 \'톰\'을 통해 매출 1천억원을 달성하며 빠르게 성장 중이다. 브랜딩과 조직문화 혁신을 직접 이끄는 \'실천형 리더\'로서, 기술 기반 홈 라이프스타일 기업의 새로운 가능성을 열어가고 있다.', 20),
('/images/linker/linker_leekangwon.jpg', '혁신 기술이 비즈니스 성과로 이어지게 만드는 것에서 의미를 찾는 엔지니어링 매니저. 다양한 문화, 조직, 사람들이 최적의 방법으로 협업하여 고객 가치를 만들도록 힘을 보태고 있습니다.', 21),
('/images/linker/linker_parkwonjun.jpg', '유저가 보고 싶은 콘텐츠, 사고 싶은 상품을 쉽게 발견하고 탐색할 수 있도록 검색과 추천 기술을 연구하고 서비스화 하고 있습니다. 수많은 데이터들이 쌓이고 분석되어 새로운 가치로 발전할 수 있도록 관리합니다.', 22),
('/images/linker/linker_leeseungbok.jpg', '아디다스코리아 CRM 담당으로 사회생활을 시작해 피자헛 브랜드 매니저, 리바이스코리아 시니어 브랜드매니저를 거쳤다. 이케아코리아 론칭 시기에 합류해 이커머스 전략 매니저로 5년간 일했고, 다이슨코리아로 옮겨 다이슨코리아닷컴을 론칭해 5년간 매출 성장을 견인했다. 2025년 슈즈 브랜드 크록스 이커머스 디렉터로 자리를 옮겼다.', 23),
('/images/linker/linker_kimhyeongjun.jpg', '2014년 신사동에 마일스톤 커피를 열었다. 2021년 2호점인 한남점을 오픈, 이후 성수에 3호점을 오픈하며 비즈니스를 확장했다. 전문성과 대중성을 모두 추구하는 것을 목표로 삼고, 회사를 운영하고 있다. 여름 중 4호점 오픈을 준비 중이다.', 24);


-- 추가
INSERT INTO linker_details (image_url, author_info, linker_id) VALUES
('/images/linker/linker_parksanghwan.jpg', NUll, 25),
('/images/linker/linker_kimmisung.jpg', NUll, 26),
('/images/linker/linker_kimminjun.jpg', NULL, 27),
('/images/linker/linker_kimyeonji.jpg', '2010년 중앙엔터테인먼트&스포츠(JES)로 입사해 일간스포츠 연예부 기자로 일했다. \'백상예술대상\'과 \'골든디스크어워즈\'의 심사, 섭외, 운영, 기획 등 시상식 전반의 업무를 16년째 담당하고 있다. 2018년부터 JTBC 엔터뉴스팀 기자로서 시상식 업무를 이어왔다. 2019년부터 3년간 \'JTBC 서울 마라톤\'의 홍보 모델 섭외 및 홍보 영상 기획을 담당했다. 문화체육관광부가 주최하고, 2018년 방탄소년단이 최연소 문화훈장을 받은  \'대한민국 대중문화예술상\' 시상식 운영과 기획을 맡았다. JTBC 패션 프로그램 \'마법옷장\' 시즌1, 2를 기획했다. JTBC \'연예특종\', 채널A \'풍문으로 들었쇼\' 등 각종 연예 정보 프로그램에 출연했다.', 28),
('/images/linker/yoosangsun.jpg', '제일기획에서 스포츠마케팅업무를 처음 담당하며 삼성-첼시FC 스폰서십, 올림픽 마케팅 등 다양한 업무를 수행하였다. 이후 한화그룹 경영기획실, 한화이글스 등을 거쳐 지금은 한화생명 문화마케팅팀에서 e스포츠 외에도 다양한 마케팅을 통해 브랜드를 알리는 일을 맡고 있다.', 29),
('/images/linker/linker_limjaetaek.jpg', '1987년 쌍용투자증권으로 증권업계에 입문했다. 이후 아이엠투자증권 대표를 거쳐 2018년부터 한양증권 대표를 맡고 있다. 스스로를 \'B급\'이라 칭하지만, 정체에 빠져 있던 한양증권을 텐베이스(10x) 신화의 주인공으로 이끌며 증권업계 스타 CEO로 부상했다. 조직문화 혁신·브랜드 리빌딩을 직접 이끄는 실천형 리더다.', 30),
('/images/linker/linker_kinyeonjeong.jpg', '김연정 상무는 2023년 7월부터 파리바게뜨 마케팅본부장으로서 상품기획부터 커뮤니케이션까지 마케팅 조직 전체를 총괄하고 있다. 최근 글로벌 스포츠 마케팅과 건강빵 브랜드 \'파란라벨\' 프로젝트 등을 통해 변화를 리드하고 있다.

1998년부터 커리어를 시작해 비즈니스 & 마케팅 분야에서 27년째 재직중이다. 광고대행사 코래드, 야후!오버추어코리아 TA팀장, 아디다스코리아 브랜드커뮤니케이션 팀장, 한국마이크로소프트 리테일세일즈&마케팅 부장, 트위터코리아 전략광고사업부 이사, 트위터 글로벌 K팝&콘텐츠 파트너십 총괄 상무, 파리바게뜨 마케팅본부장 등 글로벌 기업의 다양한 포지션을 거쳤다.', 31),
('/images/linker/linker_kimyoonjung.jpg', '이노션에서 \'무신사랑해\' 캠페인을 총괄하며 무신사와 인연을 맺었고, 이를 계기로 무신사에 합류해 글로벌 스토어 런칭부터 글로벌 마케팅을 총괄했다. 현재는 글로벌사업부문에서 마뗑킴 일본 총판을 비롯해 국내 브랜드의 해외 진출과 글로벌 마케팅 전략을 리드하고 있다.', 32),
('/images/linker/linker_kimhansu.jpg', 'SM 엔터테인먼트의 IP를 활용한 SM 공식스토어 \'광야\'의 공간기획을 총괄했다. 아이돌 팝업 및 영화 \'파묘: 그곳의 뒤편\' 등 K콘텐츠 IP를 활용하여 매장과 팝업스토어 공간기획을 담당했다. SM으로 이직 전 프라임인터내셔날 코즈니Kosney 상품기획팀 홈가전 MD를 거쳐 텐바이텐 리테일팀 VM을 담당했다.', 33),
('/images/linker/linker_haeok.jpg', '신동혁과 함께 스튜디오 신신에서 활동 중이다. 스튜디오 신신은 매체의 구조를 집요하게 탐구하며 그래픽 디자인을 깊이 있게 확장해 왔다. 특히 종이, 인쇄 기법, 제본 방식, 후가공 등의 요소를 해석해 한 권의 책으로 결합하는 방법론으로 주목받았다. 독일 \'세계에서 가장 아름다운 책\' 국제 공모전에서 최고상인 골든레터를 수상했다. 신해옥은 책의 구조 속에서 텍스트와 이미지, 페이지와 공간이 교차하는 순간을 직조하며 그 안에 흐르는 관계를 탐색한다. 읽고 본 것을 수집하고 재배치하는 그의 디자인 방법론은 책을 매개로 사물과 개념, 시각과 언어가 얽히는 방식을 고민하는 데서 출발한다.', 34),
('/images/linker/linker_donghyuk.jpg', '신해옥과 함께 스튜디오 신신에서 활동 중이다. 스튜디오 신신은 매체의 구조를 집요하게 탐구하며 그래픽 디자인을 깊이 있게 확장해 왔다. 특히 종이, 인쇄 기법, 제본 방식, 후가공 등의 요소를 해석해 한 권의 책으로 결합하는 방법론으로 주목받았다. 독일 \'세계에서 가장 아름다운 책\' 국제 공모전에서 최고상인 골든레터를 수상했다. 신동혁은 디자인의 역사와 양식, 관습과 유래를 탐구하며 전통적인 디자인 산물의 물질성과 물리적 조건을 실험한다.', 35),
('/images/linker/linker_hyeonsoo.png', '금속, 제품 디자인을 전공하고 패션, 운송기기 등 여러 영역의 디자인을 경험했다. 다양한 디자이너들과 협업 경험을 토대로 디자인 스튜디오 디시테를 창업했다. 공간 디자인과 브랜드 디자인 등 여러 프로젝트를 직접 이끌고 있다.', 36);

SELECT * FROM linker_details;



SELECT COUNT(*) AS totalCount
FROM linker l
LEFT JOIN occupation o ON l.occupation_id = o.occupation_id
LEFT JOIN linker_details ld ON l.linker_id = ld.linker_id
WHERE o.occupation = '전체';

-- 코멘트가 있는 데이터
SELECT l.*, o.occupation, ld.image_url, ld.author_info  
FROM linker l  
LEFT JOIN occupation o ON l.occupation_id = o.occupation_id  
LEFT JOIN linker_details ld ON l.linker_id = ld.linker_id  
WHERE l.comment IS NOT NULL AND LENGTH(TRIM(l.comment)) > 0  
ORDER BY l.created_at DESC  
LIMIT 12 OFFSET 0;

-- 코멘트가 없는 데이터
SELECT l.*, o.occupation, ld.image_url, ld.author_info  
FROM linker l  
LEFT JOIN occupation o ON l.occupation_id = o.occupation_id  
LEFT JOIN linker_details ld ON l.linker_id = ld.linker_id  
WHERE (l.comment IS NULL OR LENGTH(TRIM(l.comment)) = 0)  
ORDER BY l.created_at DESC  
LIMIT 12 OFFSET 0;


-- 시리즈 데이터 생성하기 - 시리즈, 아티클, 비디오 탭
CREATE TABLE series_tab (
    series_id INT AUTO_INCREMENT PRIMARY KEY,
    tit VARCHAR(50) NOT NULL
);
DESC series_tab;

INSERT INTO series_tab (tit) VALUES 
("시리즈로 보기"),
("아티클만 보기"),
("비디오만 보기");

SELECT * FROM series_tab;



CREATE TABLE contents_title (
	title_id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
DESC contents_title;


INSERT INTO contents_title (title) VALUES 
('무신사 인사이드'),
('마케터의 커리어 노트'),
('롱런 카페의 생존 전략'),
('창업의 맛'),
('폴인이 만난 사람'),
('집요한 설계, 고객경험의 승리'),
('혹한기를 뚫은 사람들'),
('폴인이 고른 책'),
('1등 브랜드의 비밀'),
('토스팀에게 듣다: 토스 10주년 \'10 to 100\''),
('폴인 PICK 요즘 이 브랜드 2.0'),
('사장의 멘탈 관리'),
('오늘의 비주얼 브랜딩'),
('마흔독립: 10년 경험 안고 나홀로 서다'),
('신수정의 트레이닝'),
('쿠팡플레이 인사이드'), 
('초개인화: 오직 1명을 위한 경험 설계'),
('허들을 넘은 예술가들'),
('[LG myCup｜폴인] ESG, 고객경험에 \'깊이\'를 더하다'),
('돌고래유괴단 인사이드'),
('콘텐츠 비즈니스 설계자들 2025'),
('직장인의 무기: 말·글·태도'),
('링커가 고른 책'),
('에디터들의 에디터'),
('굿즈에 진심인 브랜드'),
('꺾여도 계속하는 마음'),
('해외 이직, 나도 할 수 있을까?'),
('TIPS가 뽑은 2034년에 뜰 스타트업'),
('스포츠 마케팅 플레이어'),
('번아웃 생존기');

SELECT * FROM contents_title;


-- linker  + contents_title

CREATE TABLE contents_title_linker_map (
  title_id INT NOT NULL,
  linker_id INT NOT NULL
);

DESC contents_title_linker_map;

-- 없으면 NULL 안하고 5-폴인이 만난 사람에 넣음
INSERT INTO contents_title_linker_map (title_id, linker_id) VALUES 
(5, 1),
(21, 2),
(5, 3),
(5, 4),
(21, 5),
(5, 6),
(5, 7),
(5, 8),
(10, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13), 
(30, 14),
(17, 15),
(22, 16),
(5, 17),
(11, 18),
(11, 19),
(4, 20),
(5, 21),
(5, 22),
(2, 23),
(3, 24),
(5, 25),
(5, 26),
(5, 27),
(21, 28),
(29, 29),
(7, 30),
(2, 31),
(1, 32),
(11, 33),
(13, 34),
(13, 35),
(11, 36);

SELECT 
  ct.title_id,
  ct.title,
  l.linker_id,
  l.author,
  l.affiliation,
  l.comment,
  ld.image_url,
  ld.author_info
FROM 
  contents_title ct
JOIN contents_title_linker_map map ON ct.title_id = map.title_id
JOIN linker l ON map.linker_id = l.linker_id
LEFT JOIN linker_details ld ON l.linker_id = ld.linker_id
ORDER BY ct.title_id, l.linker_id;



CREATE TABLE series_contents (
	contents_id INT AUTO_INCREMENT PRIMARY KEY,
    title_id INT NOT NULL,
    sub_title VARCHAR(255) NOT NULL,
    linkers VARCHAR(255) NOT NULL,
    img_url VARCHAR(255) NULL,
	content_type ENUM('article', 'video') DEFAULT 'article',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
DESC series_contents;

-- 비디오 없어서 컨텐트타입 안넣었음
INSERT INTO series_contents (title_id, sub_title, linkers, img_url) VALUES
(1, '무신사 인사이드④ MD는 왜 무신사의 \'꽃\'이라 불릴까', '주세준 최혜지', '/images/series/1748998696394_a_11497-m.jpg'),
(1, '무신사 인사이드③ 마뗑킴·마르디, K대세를 글로벌 대세로 만들기', '김윤정', '/images/series/1749535621025_a_11496-m.jpg'),
(1, '무신사 인사이드② "하루 매출 1억" 행거 단위로 매출 관리한다', '임철우', '/images/series/1748998674981_a_11495-m.jpg'),
(1, '무신사 인사이드① 업계1위 플랫폼이 1000억 브랜드 키우는 법', '박민재', '/images/series/1749090814362_a_11494-m.jpg'),
(2, '"디지털마케팅, 광고만 돌리면 안돼"이케아·다이슨 성공시킨 비결', '이승복', '/images/series/1747718931245_a_11422-m.jpg'),
(2, '아디다스→MS→트위터→파리바게뜨…26년차 마케터의 이직 기준은?', '김연정', '/images/series/1746694364848_a_11351-m.jpg'),
(16, '쿠팡플레이 인사이드③ 손흥민→EPL, 스포츠가 쿠플에 가져온 것', '이종록', '/images/series/1744940846867_a_10800-m2.jpg'),
(16, '쿠팡플레이 인사이드② "미쳤다" 소리 들으려면? 오리지널 기획법', '문동철', '/images/series/1745245479054_a_10799-m2.jpg'),
(16, '쿠팡플레이 인사이드① \'왕좌의 게임\' \'해리포터\' 모은 비결은?', '장국성', '/images/series/1744853405621_a_10798-m.jpg'),
(16, '[무료] 쿠팡플레이 인사이드: 어떻게 국내 OTT 1위 됐나', '쿠팡플레이', '/images/series/1744853397478_a_10796-m.jpg'),
(3, '"규율? 오히려 자부심 된다" 마일스톤 커피만의 환대 비결 4', '김형준', '/images/series/1747369683756_a_11391-m3.jpg'),
(3, '"카페는 끝인상 비즈니스" 디테일로 승부한 컨플릭트 스토어', '박진훈 우창균', '/images/series/1744612710287_a_10566-m.jpg'),
(15, '신수정의 트레이닝① 퇴사가 어려워진 40대에게', '신수정', '/images/series/1743963552433_10.jpg'),
(15, '신수정의 트레이닝② 일 잘하면 승진 대신 일을 준다', '신수정', '/images/series/1743963421621_20.jpg'),
(15, '신수정의 트레이닝③ 마이크로 매니저를 질리게 하라', '신수정', '/images/series/1743963450146_30.jpg'),
(9, '동서식품① 카누 "1등의 변화는 제 살을 깎는 것"', '김대철', '/images/series/1743349499880_a_id-m12.jpg'),
(9, '동서식품② 시장점유율 90%, 맥심이 45년간 정상을 지킨 법', '하치수', '/images/series/1743333644564_a_id-m2.jpg'),
(10, '"처음부터 성공하려 하면 반드시 망해" 토스의 실험 레시피', '장민영 박서진', '/images/series/1741854407873_a_10451-m.jpg'),
(10, '\'토스는 원래 디자인을 잘하지 않았다\' 10년의 실험 기록', '강수영', '/images/series/1741854395808_a_10450-m.jpg'),
(10, '"빨리 망해야 다음이 보여요" 토스가 실패를 무기로 만드는 법', '최재호', '/images/series/1741911249525_a_10449-m.jpg'),
(12, '"직원·불경기 탓 안 해" 매출 400억 만든 청기와타운 대표 ', '양지삼', '/images/series/1741678182207_12341.jpg'),
(18, '평창올림픽 안무감독 차진엽, 커리어 정점에서 멈춘 이유', '차진엽', '/images/series/1740457934355_a_10234-m2.jpg'),
(18, '"슬럼프? 원치 않아도 찾아온다" 국가대표 연출가의 브랜딩', '양정웅 김용주', '/images/series/1739947888081_a_10021-m2.jpg'),
(21, '"16년째 백상예술대상 기획해보니" 권위와 트렌드 다 잡은 비결', '김연지', '/images/series/1747272654306_a_11373-4.jpg'),
(21, '"구구절절한 마케팅은 필패" Z세대를 영화관으로 이끈 바이포엠', '한상일', '/images/series/1737335309472_a_10038-m.jpg'),
(29, '\'팀 우승하자 상품 가입자↑\' 한화생명의 e스포츠 마케팅 전략', '유상선', '/images/series/1747009793506_a_11357-m.jpg'),
(29, '\'3년 만에 매출 7000억↑\' 넥센타이어의 스포츠 마케팅 전략', '최효선', '/images/series/1736752357044_a_9986-4.jpg'),
(29, '산리오 굿즈·KBO 포토카드… 세븐일레븐이 스포츠 주목하는 이유', '오동근 송지영', '/images/series/1736412988422_a_9985-m.jpg'),
(4, '\'한 달에 80만 장\' 수수료 0원 트래블월렛이 불러온 나비효과', '김형우', '/images/series/1750135449768_a_11536_m.jpg'),
(4, '"누구보다 잘 팔고 싶다" 아나운서→8년차 대표 김소영의 깨달음', '김소영', '/images/series/1750055009191_a_11527-1.jpg'),
(5, '배우 박정민의 허들 넘기 "일단 벌이고, 눈치 봐요"', '박정민', '/images/series/1750026455852_a_m_2.jpg'),
(6, '"고객 말 믿으면 안 된다?" 토스 UX 리서처의 고객조사 방법', '김서연', '/images/series/1749702518845_a_11526-1.jpg'),
(8, '당신이 미루는 이유, 게으름 때문 아니다?  의지박약 극복법', '박초롱', '/images/series/1748823667478_a_11461-m.jpg'),
(31, '"기분 나쁜데 정색하긴 애매" 직장에서 미세공격 당했다면', '남대희', '/images/series/1748591055334_a_11453-6.png'),
(17, '\'1년 만에 200만명 돌파\' 제타가 1020 사로잡은 전략은', '박상예', '/images/series/1748397601146_a_11453-m_02.png'),
(22, '마케터 숭, 16년간 일터에서 무기 된 \'질문 노트\' 공개하다', '이승희', '/images/series/1748329146502_a_11450-m.jpg'),
(4, '\'7년차 매출 1000억\' 93년생 앳홈 대표의 사업 생존기', '양정호', '/images/series/1747965092325_a_11438-m.jpg'),
(11, '"저속노화, 그다음은?" 정희원 교수×CJ햇반 협업 비하인드', '정희원 김숙진 김유림', '/images/series/1747970985204_a_11435-m.jpg'),
(7, '패배감 젖은 팀 살리려면? 실적 10배 키운 증권사 대표의 전략', '임재택', '/images/series/1747103681712_a_11364-3.jpg');

SELECT * FROM series_contents;


-- contents_title, series_contents title_id 매개로 컨텐츠에 콘텐츠타이틀이 있는 것만 출력 없으면 아예 출력 안됨
SELECT
  ct.title_id,
  ct.title AS series_title,
  sc.contents_id,
  sc.sub_title,
  sc.linkers,
  sc.img_url,
  sc.content_type,
  sc.created_at
FROM series_contents sc
INNER JOIN contents_title ct ON sc.title_id = ct.title_id
ORDER BY ct.title_id, sc.contents_id;




-- title 제안 내용 db, 리스트형 데이터 contents_title id 연결
CREATE TABLE proposal (
	proposal_id INT AUTO_INCREMENT PRIMARY KEY,
    title_id INT NOT NULL,
    why TEXT NULL,
	for_whom1 TEXT NULL,
    for_whom2 TEXT NULL,
    for_whom3 TEXT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

DESC proposal;

INSERT INTO proposal(title_id, why, for_whom1, for_whom2, for_whom3) VALUES 
(1, '4.5조원. 무신사의 2024년 거래액입니다. 
매출은 1조원. 6년 만에 매출만 11배 커졌습니다.

고속 성장의 핵심엔 \'덕후의 집착\'이 있었습니다. 

"여긴 패션을 미치도록 사랑하면서도, 시장을 아는 사람들의 직관으로 가득찬 곳이에요."

22년간 축적한 데이터에 \'덕후력\'이 더해지니, 혹한기에도 급속 성장하는 패션 공룡이 됐습니다. 

반대로 움직이는 전략도 통했습니다.
다들 오프라인 사업을 줄이는 불경기인데도, 2000평 규모의 스토어 4호점을 준비 중이고요. 글로벌 진출도, 강점인 온라인에서 출발하지 않았습니다. 오히려 오프라인 접점을 만드는 데 주력했죠. 
언뜻 보기에 \'거꾸로 가는 게 아닌가\' 싶은 행보, 그 이면이 궁금했습니다.

①브랜드개발 ②오프라인 스토어 ③글로벌 전략 ④상품기획(MD).
핵심 밸류체인을 따라 무신사를 심층 해부하는 인사이드 시리즈, 지금 시작합니다.', 
'업계 1위 유니콘이 된 무신사, 핵심 전략이 궁금하다면', 
'작은 브랜드를 빠르게 성장시키는 방법이 궁금하다면', 
'오프라인·글로벌로 확장하는 무신사의 미래 사업 전략이 궁금하다면'),
(2, '폴인 구독자 중 가장 많은 직군, 마케터입니다. 그래서 압도적인 성과를 낸 마케터를 자주 인터뷰하는데요. 종종 궁금해졌어요. 저 사람의 주니어 시절은 어땠을까? 왜 마케터가 됐을까? 이정표가 된 프로젝트는 뭘까? 누구와 함께 일하며 가장 크게 성장했을까? 이 질문에 대한 답을 모아 \'마케터의 커리어 노트\'에 담기로 했어요. ①좋은 마케팅 레퍼런스가 필요할 때 ②커리어가 고민될 때 언제든 꺼내볼 수 있도록요.',
'마케터 커리어 패스를 잘 가꿔나가고 싶은 분',
'업력 10년 차 이상 마케터의 내공, 생각법이 궁금한 분',
'압도적인 성과를 낸 마케팅 프로젝트 기획 비하인드가 알고 싶은 분');

INSERT INTO proposal(title_id, why, for_whom1, for_whom2, for_whom3) VALUES
(16, '\'쿠팡이 웬 OTT?\' 소리를 듣던 쿠팡플레이가 어느새 티빙, 웨이브를 제치고 1등에 올랐습니다. \'왕좌의 게임\' \'해리포터\' 등 글로벌 콘텐츠를 모으고, 지드래곤·칸예 웨스트 콘서트를 함께하고, 국내 최초 MLB 월드투어 서울 시리즈를 선보이더니, 세계 최대 축구 리그 EPL 중계권을 확보하기까지. 그야말로 \'미친 폼\'을 어떻게 만들었는지 궁금했어요. 

콘텐츠 수급, 사업, 스포츠 총괄 3인을 만나 숫자 뒤의 생생한 전략을 들었습니다. 4년 반 사이에 일어난 쿠팡플레이의 폭발적인 성장기, 지금 바로 만나보세요.',
'쿠팡플레이의 가파른 성장 전략이 알고 싶다면',
'"미쳤다" 소리 나오는 콘텐츠 기획 노하우가 필요하다면',
'\'작게 실험하고 확실히 베팅한다\' 쿠팡플레이가 일하는 법이 궁금하다면');

INSERT INTO proposal(title_id, why, for_whom1, for_whom2, for_whom3) VALUES
(3, '10만 개. 한국에 존재하는 카페의 수입니다. 한국인의 커피 사랑은 각별하지만, 비즈니스는 전혀 다른 이야기죠. 누구나 카페를 열 수는 있지만, 오랜 기간 살아남은 브랜드는 드뭅니다. 레드오션을 뚫고 롱런해온 카페들은 어떤 철학과 전략을 갖고 있을까요? 연희동의 터줏대감 ‘매뉴팩트 커피’, 오마카세와 편집숍 콘셉트로 사업을 확장해온 ‘컨플릭트 스토어’, 특별한 환대로 고객의 마음을 사로잡은 ‘마일스톤’을 만났습니다. 흔들림을 이겨내고 자리를 지켜온 이들의 생존 전략을 지금 만나보세요.',
'레드오션 커피 시장에서 살아남은 브랜드의 전략이 궁금한 분',
'차별화된 공간, F&B 경험을 설계하고 싶은 분',
'10년간 사업을 지속하고 확장해온 창업자의 이야기를 듣고 싶은 분'),
(15, '커리어도 속성 과외를 받을 수는 없을까요? 커리어 경력 30년, 24년간 임원을 맡은 신수정 대표를 \'커리어 트레이너\'로 모셨습니다. 임팩트리더스아카데미 대표이자 전 KT 부사장으로, 『커넥팅』 『일의 격』 『거인의 리더십』 을 펴냈죠. 그에게 회사 안팎 커리어를 꾸리기 위해 꼭 필요한 질문을 추려 물었어요. 

- 나만 승진 누락되면 어떻게 할까?
- 왜 일을 열심히 해도 인정받지 못할까?
- 마이크로 매니저 상사를 만났을 때 대처법은?
- 팀장 이후 커리어는 어떻게 설계해야 할까?
- 내향인 회사원의 사내 정치, 영업 스킬은? 

단순한 조언을 넘어, 손에 잡히는 명확한 커리어 가이드가 필요하다면? 이 시리즈를 놓치지 마세요!',
'커리어 속성 과외를 받고 싶다면',
'팀장 이후, 40대의 커리어 설계법이 궁금하다면',
'연차가 쌓여도 여전히 일이 힘들다면'),
(9, '업계에서 압도적 1등을 유지하는 곳들을 만났습니다. 어떻게 1등을 만들었는지, 그 자리를 내주지 않기 위해 어떤 숱한 변화를 택했는지 궁금했어요. 시장 점유율 80%에 달하는 동서식품의 카누와 맥심, 건강기능식품 업계 부동의 1위, 120년 역사의 정관장을 먼저 만났습니다. \'커피는 맥심\' \'홍삼은 정관장\' 이 익숙한 공식이 성립되기까지 치열한 움직임이 있었습니다. 어떤 고민과 결정이 지금의 그들을 만들었을까요?',
'독보적인 1등이 어떻게 만들어지는지 궁금하다면',
'국민 브랜드의 치열한 생존 전략이 듣고 싶다면',
'롱런하는 브랜드가 쌓아온 비즈니스 인사이트가 필요하다면'), 
(12, '\'회사원의 퇴사 고민 시점이 3년·5년·7년이라면 식당 직원의 퇴사 구간은 3개월·5개월·7개월이다?\' 멘탈 관리를 가장 잘 하는 사람은 누구일까요? 아마 장사하는 사장님들일 겁니다. 일하다 갑자기 사라지는 직원부터 무단결근, 돈 빌리고 잠수타는 사람까지. 회사 밖에서 벌어지는 일은 직장인이 상상하는 범주를 뛰어넘기 때문인데요.

바닥부터 시작해 건물주 횡포, 불경기, 직원 퇴사를 맨손으로 견딘 사장님들은 어떻게 흔들리지 않는 \'초 강철 멘탈\'이 됐을까요?

고통을 피하지 않고 정면돌파해 성장한 사장님의 멘탈 관리법, 지금 공개합니다.',
'직원 퇴사·불경기·건물주 횡포를 딛고 성장한 사장의 멘탈 관리법이 궁금 하다면',
'성공적인 조직 관리와 리더십, 사업을 성장 시키기 위한 비결을 알고 싶다면',
'직장 밖에서 사업하는 사람들의 생각법을 엿보고 싶다면'),
(17, '초개인화가 만드는 초경험, 어떻게 설계할까요?
AI로 모든 서비스가 \'초개인화\'되고 있습니다. 하지만 섬세한 경험 설계가 뒷받침되지 않으면 고객은 떠나갑니다. 요즘 고객은 단지 상품을 추천받는 걸로는 만족하지 못해요. 내 의견이 실시간 결과로 반영되거나, 수백여 가지 선택지 중 내 맥락에 맞는 서비스를 경험하고 싶어하죠. 온·오프라인 초개인화 시장에 뛰어든 브랜드를 만났습니다. 초개인화 시대, 이들은 고객의 마음을 어떻게 읽고 있을까요?',
'초개인화 시대에 대응할 고객경험 설계를 고민 중이라면',
'AI 기술을 우리 브랜드에 효과적으로 적용하려면',
'기술 변화의 흐름을 읽고 비즈니스 인사이트를 얻고 싶다면'),
(18, '커리어의 장애물, 예술가들은 어떻게 넘었을까요?

예술가에게 커리어는 선택과 극복의 연속입니다. 안정적인 길과 소속감을 포기해야 할 때도, 예측하기 어려운 변화를 받아들여야 할 때도 찾아오죠. 예술가들은 \'일의 과정\'에서 이 허들을 어떻게 넘어 왔을까요? 그 도약의 순간에서 얻었던 레슨런은 무엇일까요.

국립현대미술관의 김용주 기획관과 함께 허들을 넘어온 예술가들을 만났습니다. 
자신만의 정체성과 영감으로 커리어를 꾸려온 이들과 함께 예상치 못한 멈춤과 시련을 기회로 바꾸는 법을 탐구합니다.',
'예술가의 창의적인 문제 해결 방식에서 인사이트를 얻고 싶다면',
'자신의 일에 대한 확신이 흔들릴 때, 새로운 방향이 필요하다면',
'실패를 극복하고 더 나은 성장 방식을 찾고 싶다면');

SELECT * FROM proposal;


SELECT
  ct.title_id,
  ct.title AS series_title,
  p.proposal_id,
  p.why,
  p.for_whom1,
  p.for_whom2,
  p.for_whom3,
  p.created_at
FROM proposal p
INNER JOIN contents_title ct ON p.title_id = ct.title_id
ORDER BY ct.title_id, p.proposal_id;



-- 시리즈 리스트 Id 페이지 테이블
CREATE TABLE contents_linker_map (
    id INT AUTO_INCREMENT PRIMARY KEY,
    contents_id INT NOT NULL,
    linker_id INT NOT NULL
);

-- CREATE TABLE contents_linker_map (
-- 	id INT AUTO_INCREMENT PRIMARY KEY,
-- 	title_id INT NOT NULL,
--     linker_id INT NOT NULL
-- );
DESC contents_linker_map;

INSERT INTO contents_linker_map (contents_id, linker_id) VALUES 
(1, 11),
(1, 12),
(2, 32),
(3, 10),
(4, 13);

-- (2, 31),
-- (3, 24),
-- (4, 20),
-- (6, 9),


-- (7, 30),
-- (11, 19),
-- (11, 18),
-- (17, 15),
-- (22, 16),
-- (29, 29);

SELECT * FROM contents_linker_map;



-- 링커+타이틀이랑 연결할 series_contents + 디테일
CREATE TABLE contents_detail (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    contents_id INT NOT NULL,
    sentence1 TEXT,
    sentence2 TEXT,
    sentence3 TEXT,
    h3 VARCHAR(255),
    p TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

DESC contents_detail;

INSERT INTO contents_detail (contents_id, sentence1, sentence2, sentence3, h3, p) VALUE 
(1, 
'무신사의 모든 사업에 MD가 있습니다. 가장 힘든 건 역시 영업이라고요. 300억 원 브랜드를 기어코 입점시키는 MD만의 영업 비밀은 뭘까요?',
'커버낫과 예일, 1년만에 300억 거래액을 달성했습니다. 브랜드의 일원이 됐다는 생각으로 계속 이슈를 만든 덕분이에요.',
'수만 개의 상품, 수십 페이지의 기획전을 일일이 수기로 배열했어요. \'눈에 띄면 좋겠다\'는 패션 덕후의 집착이 그 동력이었죠.',
'MD가 못하면 입점 브랜드는 멈춰있습니다. 
세일하다 끝나는 거예요.',
'무신사 성수 N1 오피스에서 만난 유니섹스패션팀 주세준, 남성패션팀 최혜지 MD. ©무신사');

INSERT INTO contents_detail (contents_id, sentence1, sentence2, sentence3, h3, p) VALUE 
(2, 
'J커브를 그리며 급성장하는 한국 패션브랜드와 달리, 일본 시장은 포물선형으로 느리게 성장합니다. 온라인 구매율도 20% 미만이죠.',
'무신사는 오프라인을 파고들었습니다. 시부야 대형 쇼핑몰에 마뗑킴 1호점을 내고, B2C 마케팅을 멀티 채널로 펼쳤죠.',
'2024년 중화권(홍콩·마카오·대만)에 진출한 마뗑킴. 1년 간 해외 시장에서 몸으로 부딪히며 쌓은 노하우를 이번 일본 진출에 반영했다는데요. 오픈 4일만에 3억 2000만원을 판 전략. 어떻게 짰을까요?',
NULL, 
'마뗑킴 시부야점 매장에서 만난 김윤정 무신사 글로벌 비즈니스본부 실장. ©폴인'),
(3, '고정비는 크지만 수익 내기는 어려운 오프라인 편집숍 사업. 혹한기에도 무신사는 오프라인 편집숍 3개를 오픈했습니다. 왜 무신사는 거꾸로 갈까요?',
'최소 단위를 \'행거 수\'로 설정하고 3개월마다 입점 브랜드를 바꿨어요. 오프라인도 온라인처럼 기민해야 했거든요.',
'복잡한 검증보다는 실행에 무게를 뒀습니다. 당장의 손익보다 미래 시장이 중요하다고 봤죠.',
'비용을 줄여야 한다면
심플한 답은 오프라인을 없애는 거예요.
근데 다른 방법이 있지 않을까요?',
'무신사 캠퍼스에서 만난 무신사커머스부문 리테일팀 임철우 팀장. ©무신사'),
(4,
'무신사에겐 브랜드=콘텐츠입니다. 고객을 끌어올 브랜드를 발굴해 육성하는 게 매우 중요하죠. 3000억원을 투자해 브랜드 지원을 한 이유입니다.',
'급성장할 브랜드, 어떻게 판단할까요? ①확장 가능성 ②브랜딩 역량을 바탕으로 MD가 밀착 관찰합니다.',
'브랜드개발본부 박민재 실장은 무신사 브랜드 기획자라면 \'감도와 오너십\'이 있어야 한다고 강조합니다. 브랜드가 알아서 성장하길 기다리지 않고 적극 액션을 취해야 한다고요.',
'브랜드가 알아서 탄생해주길 기다리는 소극적 태도론 안 돼요.',
'무신사 사옥 앞 조형물에서 포즈를 취하고 있는 박민재 실장. ©무신사 포토팀');


SELECT * FROM contents_detail;

-- 처음에 title_id랑 linker_id를 합쳐 놓지 않아서 contents_linker_map을 만들었는데 이걸 지우면 꼬이기 때문에 일단 살림
-- title_id에 연결된거 활용하면 될거 같긴한데 어차피 디테일을 추가해야해서 냅둠
SELECT
  ct.title_id,
  ct.title AS series_title,
  sc.contents_id,
  sc.sub_title,
  sc.img_url,
  sc.created_at,
  cd.sentence1,
  cd.sentence2,
  cd.sentence3,
  cd.h3,
  cd.p,
  l.linker_id,
  l.author,
  l.affiliation,
  ld.image_url AS linker_details_img_url
FROM contents_title ct
JOIN series_contents sc ON ct.title_id = sc.title_id
LEFT JOIN contents_linker_map clm ON sc.contents_id = clm.contents_id
LEFT JOIN linker l ON clm.linker_id = l.linker_id
LEFT JOIN linker_details ld ON l.linker_id = ld.linker_id
LEFT JOIN contents_detail cd ON sc.contents_id = cd.contents_id
WHERE sc.content_type = 'article'
ORDER BY ct.title_id, sc.contents_id, l.linker_id;





CREATE TABLE series_combined_table (
  contents_id INT AUTO_INCREMENT PRIMARY KEY,
  title_id INT NOT NULL,
  proposal_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  sub_title VARCHAR(255) NOT NULL,
  linkers VARCHAR(255) NOT NULL,
  img_url VARCHAR(255),
  content_type ENUM('article', 'video') DEFAULT 'article',
  why TEXT,
  for_whom1 TEXT,
  for_whom2 TEXT,
  for_whom3 TEXT,
  linker_id INT,
  author VARCHAR(255),
  affiliation VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DESC series_combined_table;

INSERT INTO series_combined_table (
  title_id, proposal_id, title, sub_title, linkers, img_url, content_type,
  why, for_whom1, for_whom2, for_whom3,
  linker_id, author, affiliation,
  created_at, updated_at
)
SELECT
  sc.title_id,
  p.proposal_id,
  ct.title,
  sc.sub_title,
  sc.linkers,
  sc.img_url,
  sc.content_type,
  p.why,
  p.for_whom1,
  p.for_whom2,
  p.for_whom3,
  l.linker_id,
  l.author,
  l.affiliation,
  sc.created_at,
  sc.updated_at

FROM
  series_contents sc
JOIN proposal p ON sc.title_id = p.title_id
JOIN contents_title ct ON sc.title_id = ct.title_id
JOIN contents_title_linker_map map ON sc.title_id = map.title_id
JOIN linker l ON map.linker_id = l.linker_id;


-- 시리즈.js 시리즈Id에서 쓰고 있음
SELECT
    contents_id,
    p.title_id,
    p.proposal_id,
    ct.title,
    sc.sub_title,
    sc.linkers,
    sc.img_url,
    sc.content_type,
    p.why,
    p.for_whom1,
    p.for_whom2,
    p.for_whom3,
    sc.created_at,
    p.created_at
    FROM
    proposal p
    LEFT JOIN series_contents sc ON p.title_id = sc.title_id
    LEFT JOIN contents_title ct ON p.title_id = ct.title_id;

SELECT * FROM series_combined_table;


-- 검색어 키워드 테이블 추가 - 위에 contents_id + linker연결 한거 대신 쓸것, 
CREATE TABLE keywords (
	keyword_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

DESC keywords;

INSERT INTO keywords(name) VALUES 
('기획'),
('커리어'),
('AI'),
('브랜딩'),
('창업'),
('마케팅'),
('콘텐츠'),
('이직'),
('트렌드'),
('디자인'),
('리더십'),
('글쓰기'),
('공간'),
('F&B'),
('조직문화'),
('프로'),
('테크'),
('롱런'),
('네트워킹'),
('협업');

SELECT * FROM keywords;


CREATE TABLE content_keywords_map (
  id INT AUTO_INCREMENT PRIMARY KEY,
  contents_id INT NOT NULL,
  keyword_id INT NOT NULL
);


DESC content_keywords_map;

INSERT INTO content_keywords_map (contents_id, keyword_id) VALUES 
(1, 9),
(1, 20),
(2, 1),
(2, 4),
(3, 6),
(3, 13),
(4, 7),
(4, 9),
(5, 4),
(5, 6),
(6, 1),
(6, 6),
(7, 1),
(7, 7),
(8, 1),
(8, 7),
(9, 1),
(9, 7),
(10, 1),
(10, 7),
(11, 5),
(11, 15),
(12, 14),
(13, 2),
(14, 11),
(15, 2),
(16, 4), 
(17, 4),
(18, 15),
(19, 10),
(20, 15),
(21, 5),
(22, 2),
(23, 2),
(24, 7),
(25, 6),
(26, 6),
(27, 4),
(28, 4),
(29, 9),
(30, 1),
(31, 7), 
(32, 20),
(33, 18),
(34, 2), 
(35, 3),
(36, 6), 
(37, 5), 
(38, 1), 
(39, 15);

SELECT * FROM content_keywords_map;

CREATE TABLE linker_keywords_map (
  id INT AUTO_INCREMENT PRIMARY KEY,
  linker_id INT NOT NULL,
  keyword_id INT NOT NULL
);

DESC linker_keywords_map;


INSERT INTO linker_keywords_map (linker_id, keyword_id) VALUES 
(1, 6),
(1, 2),
(2, 9), 
(3, 10),
(4, 2), 
(5, 7), 
(6, 14), 
(7, 13), 
(8, 17), 
(9, 1), 
(10, 6),
(10, 13),
(11, 9), 
(11, 20),
(12, 9),
(12, 20), 
(13, 7),
(13, 9),
(14, 2),
(14, 18),
(15, 1),
(15, 3), 
(16, 2),
(16, 6),
(17, 6), 
(18, 1), 
(18, 20),
(19, 1),
(19, 20),
(20, 4), 
(20, 5), 
(21, 3), 
(21, 7),
(22, 3),
(22, 7),
(23, 4),
(23, 6),
(24, 5),
(24, 15),
(25, 1),
(25, 4),
(26, 1),
(26, 4), 
(27, 1), 
(27, 4),
(28, 1),
(28, 7), 
(29, 1), 
(29, 6), 
(30, 2), 
(30, 15),
(31, 1),
(31, 4), 
(32, 1), 
(32, 6), 
(33, 4),
(33, 13), 
(34, 10),
(35, 10),
(36, 10);


SELECT * FROM linker_keywords_map;




CREATE TABLE proposal_keywords_map (
  id INT AUTO_INCREMENT PRIMARY KEY,
  proposal_id INT NOT NULL,
  keyword_id INT NOT NULL
);

DESC proposal_keywords_map;

INSERT INTO proposal_keywords_map (proposal_id, keyword_id) VALUES 
(1, 1),
(1, 6),
(1, 20), 
(2, 1), 
(2, 6),
(3, 1), 
(4, 4), 
(4, 9), 
(4, 15), 
(5, 2), 
(5, 8),
(5, 11), 
(6, 1), 
(6, 6), 
(6, 16), 
(7, 8), 
(7, 16), 
(8, 3), 
(9, 2), 
(9, 7);

SELECT * FROM proposal_keywords_map;



-- 콘텐츠
SELECT sc.*
FROM series_contents sc
JOIN content_keywords_map ckm ON sc.title_id = ckm.contents_id
JOIN keywords k ON ckm.keyword_id = k.keyword_id

WHERE k.name = '커리어'
LIMIT 0, 1000;

-- 링커
SELECT l.* FROM linker l
JOIN linker_keywords_map lkm ON l.linker_id = lkm.linker_id
JOIN keywords k ON lkm.keyword_id = k.keyword_id

WHERE k.name = '기획';

-- proposal
SELECT p.*
FROM proposal p
JOIN proposal_keywords_map pkm ON p.proposal_id = pkm.proposal_id
JOIN keywords k ON pkm.keyword_id = k.keyword_id;

SHOW DATABASES;
