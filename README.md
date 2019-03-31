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

## 프로젝트 구성 (MVVM 패턴)

RealmManager에 Realm관련 코드가 다 들어가있음. ViewModel들은 RealmManager안의 function들을 이용해야함

![스크린샷 2019-03-30 오후 10 29 12](https://user-images.githubusercontent.com/9502063/55276821-90dba380-533b-11e9-9220-80b798f54756.png)
![스크린샷 2019-03-30 오후 10 29 28](https://user-images.githubusercontent.com/9502063/55276824-92a56700-533b-11e9-8463-c6e45c7872db.png)
![스크린샷 2019-03-30 오후 10 29 39](https://user-images.githubusercontent.com/9502063/55276829-976a1b00-533b-11e9-9f22-ba70e1f953f2.png)



![스크린샷 2019-03-31 오후 2 35 17](https://user-images.githubusercontent.com/9502063/55285213-36d1f100-53c2-11e9-9f91-84757abe6989.png)



### MVC -> MVVM 

- VC가 Model과 소통하던 부분이 다 VM으로 빠지고 VC가 View로 들어가게 되면서 VC가 엄청 가벼워졌다. VC에는 View 관리하는 코드만 있어서 깔끔하다 
- Model과 소통하는 부분, 특히 RealmManager을 사용하는 코드는 다 VM으로 들어가게 되어서 보기도, 관리하기도 엄청 편해졌다  (Realm을 사용하는 코드들을 한번에 볼 수 있는 것이 좋다)
- VM을 보고 프로젝트에서 쓰이는 데이터 및 기능들을 파악하기 쉬운 것 같다 
- Unit Testing이 좋다는 장점도 있는데, 해봐야겠다 : )  

