# BibleCheckList
성경읽기표 


## 기획의도
나는 성경의 각 권들을 왔다갔다 하면서 읽어서 성경읽기표가 필요한데  
다이어리에 끼워두고 다니기도 불편하고, 기존의 성경읽기표 앱들은 너무 안예쁘다 광고도 들어가있고  
내가 만들어버리자 :)  


## 사용할 라이브러리
* Realm
  
  * 창세기,출애굽기.... BookClass로 정의
  * BookClass
    * name:Enum
    * catergory:Enum (구약/신약) 
    * totalPageCount:Int (한 권 당 총 페이지 수)
    * myPageList:[String] (내가 읽은 페이지들)  
    
    
## 기획 & UI 

### 1차 버전(은진 사용용)

* 탭 메뉴에는 Daily(잠언&시편) / 구약(-잠언&시편) / 신약 들어간다  

### 2차 버전(배포용)

* 탭을 구성할 수 있게 해주고 안에 들어갈 성경 각 권들도 구성할 수 있게 해준다
* 귀찮은 사람들을 위해 여러 테마도 함께 제공한다 
* 가로로 뒤집으면 한눈에 보여지게 
* 드래드해서 CELL의 순서를 바꿀수있는 reorderable tableview 만들기 
* key color 설정해서 색깔바뀔수있게 



## 개발 

* tableviewCell xib 만들기 
  UI 
  * name
  * totalPageCount만큼 collectionViewCell을 가진 collectionView 

  BookClass에 대응한다  
  초기화할때  
  * name과 totalPageCount로 cell을 만들고
  * myPageList에 해당하는 값들 색칠해주기 
  
* 사용자가 collectionviewCell을 터치할때마다 색칠  
  토글 버튼 식으로 하는게 좋을듯?!?! 
    
 
