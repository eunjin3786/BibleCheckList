# BibleCheckList
성경읽기표 



#### ✅ 읽은 장은 쳌
<a href="https://imgflip.com/gif/2n5u4o"><img src="https://i.imgflip.com/2n5u4o.gif" title="made at imgflip.com"/></a>







#### ✅ 스와이프로 한 권을 다 읽으면 편하게 쳌쳌 
<a href="https://imgflip.com/gif/2n5tr4"><img src="https://i.imgflip.com/2n5tr4.gif" title="made at imgflip.com"/></a> 


#### ✅ 설정에 들어가서 현재 읽고 있는 권을 Daily로 빼기  
<a href="https://imgflip.com/gif/2wnkuh"><img src="https://i.imgflip.com/2wnkuh.gif" title="made at imgflip.com"/></a>


#### ✅ 성경 66권 읽어보자 :) 
<a href="https://imgflip.com/gif/2n5uho"><img src="https://i.imgflip.com/2n5uho.gif" title="made at imgflip.com"/></a>




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
    * isDaily (Daily탭에 추가되었는지)


## 개발 

* tableviewCell xib 만들기 
  UI 
  * name
  * totalPageCount만큼 collectionViewCell을 가진 collectionView



## 프로젝트 구성 ( MVC 패턴 )

![스크린샷 2019-03-30 오후 10 29 12](https://user-images.githubusercontent.com/9502063/55285147-c7a7cd00-53c0-11e9-94ef-a67e180fa1cc.png)

![스크린샷 2019-03-31 오후 2 26 03](https://user-images.githubusercontent.com/9502063/55285158-ec9c4000-53c0-11e9-8ca1-ed9768ce054a.png)



VC에 Model과 interact하는 코드가 다 들어가있다 
(ex-books 같은 데이터 / RealmManager와 소통하는 코드 ) 



![스크린샷 2019-03-31 오후 2 34 02](https://user-images.githubusercontent.com/9502063/55285206-09854300-53c2-11e9-8d14-d0c23e4a60fc.png)

