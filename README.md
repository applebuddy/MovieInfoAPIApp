# API를 활용한 영화정보 앱 
- API를 활용한 영화정보 앱 프로젝트

<br>

## 개요
- 영화정보 API를 활용한 영화정보 앱 만들기 연습 예제
- 활용 API 사이트 : https://yts.lt/api#list_movies

<br>
<br>

### 앱 기능 
- MainViewController
  - PickerView로 최소평점을 설정 후 하단 버튼을 누르면 영화정보 API에 데이터를 요청합니다.
    - 데이터 처리 간 API요청 버튼 및 최소평점 설정버튼은 Disabled상태가 되어 중복 API 호출을 방지합니다. 
  - 데이터 수신 성공 시 MovieListViewController로 이동합니다.
- MovieListViewController
  - MainViewController에서 설정 한 최소평점을 기준, 평점 오름차순으로 영화 데이터를 보여줍니다. 
    - 영화목록은 최대 10개 까지만 보여줍니다.
  - 영화목록 셀 선택 시 해당 영화의 세부 정보를 보여주는 MovieDetailViewController로 이동합니다.
- MovieDetailViewController
  - 선택한 영화 셀의 세부 영화정보(영화 줄거리, 평점, 이미지)를 보여줍니다.

<br>

### 개발기간
-  3일 ('19. 8. 31. ~ 9. 2.)

<br>

### 영화정보 앱 실행 예시

<div>
<img width="250" src="https://user-images.githubusercontent.com/4410021/64100803-60df7300-cda7-11e9-84a5-d7fd843a5913.png">&nbsp
<img width="250" src="https://user-images.githubusercontent.com/4410021/64100806-62a93680-cda7-11e9-82bc-acc7172ebedc.png">&nbsp
<p>
<img width="250" src="https://user-images.githubusercontent.com/4410021/64100809-63da6380-cda7-11e9-8297-a2878a1aacdc.png">&nbsp
<img width="250" src="https://user-images.githubusercontent.com/4410021/64100813-650b9080-cda7-11e9-83dd-76c5aa39abc1.png"> 
</div>
