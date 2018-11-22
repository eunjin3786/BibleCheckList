# BibleCheckList
성경읽기표 




<a href="https://imgflip.com/gif/2n5tr4"><img src="https://i.imgflip.com/2n5tr4.gif" title="made at imgflip.com"/></a> 

## 기획의도
나는 성경의 각 권들을 왔다갔다 하면서 읽어서 성경읽기표가 필요한데  
다이어리에 끼워두고 다니기도 불편하고, 기존의 성경읽기표 앱들은 너무 안예쁘고 불편.. 광고도 들어가있고  
내가 만들어버리자 :)  


## 사용할 라이브러리
* Realm
  
  * 창세기,출애굽기.... BookClass로 정의
  * BookClass
    * title
    * PageObject(pageNumber와 isRead로 구성)의 배열
    * catergory (구약/신약 등) 
    
    
    
## 기획 & UI 

### 1차 버전(은진 사용용)

* 탭 메뉴에는 Daily(잠언&시편) / 구약(-잠언&시편) / 신약 들어간다  

### 2차 버전(배포용)

* 탭을 구성할 수 있게 해주고 안에 들어갈 성경 각 권들도 구성할 수 있게 해준다
* 귀찮은 사람들을 위해 여러 테마도 함께 제공한다 
* 가로로 뒤집으면 한눈에 보여지게 
* 드래드해서 CELL의 순서를 바꿀수있는 reorderable tableview 만들기 
* key color 설정해서 색깔바뀔수있게 

* 공부한 것을 적용해보기 위해 RX / MVVM / 완전완전 FP 로도 해보기 :) 



## 개발 

* tableviewCell xib 만들기 
  UI 
  * name
  * totalPageCount만큼 collectionViewCell을 가진 collectionView 

  
* 사용자가 collectionviewCell을 터치할때마다 색칠  
  토글 버튼 식으로 하는게 좋을듯?!?! 
    
 
 
 <a href="https://imgflip.com/gif/2n5tex"><img src="https://i.imgflip.com/2n5tex.gif" title="made at imgflip.com"/></a>
