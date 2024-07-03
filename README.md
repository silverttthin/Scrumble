# 스크럼블

### Outline
---

<img src="https://github.com/silverttthin/madcamp_week1/assets/83443857/fe54f095-d23a-41d9-ad48-7249e4696259" width="200">

<br>
<br>  

-   스크럼 작성 관리 도구인 **스크럼블**에 오신 것을 환영합니다!
    -   스크럼블은 스크럼 방법론과 서양 대표 아침식사인 🍳스크램블 에그🥚의 쉽고, 빠른 조리 과정에서 영감을 받아 이름을 지었습니다.
    -   스크럼블로 매일 아침 10시 30분 스크럼을 쉽게, 그리고 빠르게 시작하세요.
    -   그리고 프로젝트 관리의 즐거움과 생산성을 경험하세요.



## Team
---
|<img src="https://avatars.githubusercontent.com/u/83443857?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/24761111?v=4" width="150" height="150"/>|
|:-:|:-:|
|Lee Si Woong<br/>[@silverttthin](https://github.com/silverttthin)|Jaehyun Jeong<br/>[@RGLie](https://github.com/RGLie)|
    

### Using Stack

----------
Flutter            |  Android Studio
:-------------------------:|:-------------------------:
![](https://img.icons8.com/?size=100&id=pCvIfmctRaY8&format=png&color=000000)  |  ![](https://img.icons8.com/?size=100&id=04OFrkjznvcd&format=png&color=000000)

### About

----------

1.  **스크럼 추가 탭**

-   스크럼을 작성하는 페이지입니다.
    
    <img src="https://github.com/silverttthin/madcamp_week1/assets/83443857/ab04abb0-6b60-4d49-8fb4-731abe906de1" width="300">
    
    -   스크럼 내용을 적고 완료 버튼을 눌러 `MarkDown`으로 변환된 스크럼을 게시합니다.
        
        -   스크럼
            -   어제 무엇을 하셨나요?
            -   오늘 무엇을 할 예정인가요?
            -   무엇을 느꼈나요?
            -   오늘의 한 마디?
        -   만약 작성자를 선택하지 않거나 이미지를 선택하지 않으면 경고 `Toast` 를 표시하고 스크럼을 추가하지 못합니다.
    -   사용자 추가 버튼을 눌러 스크럼 작성자 연락처 선택 페이지로 넘어갑니다.
        
        <img src="https://github.com/silverttthin/madcamp_week1/assets/83443857/defe16a9-9364-4f6f-b349-add53d8b8603" width="300">
        
        -   연락처 선택 페이지에서는 이름, 연락처, 소개 정보를 `ListView` 형식으로 보여줍니다.
        -   검색창에 이름을 입력하면 원하는 사용자가 위치한 스크롤로 이동합니다.
        -   사용자 카드를 길게 눌러 해당 사용자의 MBTI, 전화번호, 소개가 적힌 상세 `Dialog`창을 띄웁니다.
    -   사진 추가 `Button` 을 클릭하면 이미지를 선택할 수 있는 `Dialog`창이 나타납니다.
        
        <img src="https://github.com/silverttthin/madcamp_week1/assets/83443857/e3263277-68af-4391-8f6b-b0d4ce1a7ac7)" width="300">
        
        -   여러 사진들의 `GridView` 중 하나를 선택하면 사진 추가 `Button` 은 사라지고 `Image Widget` 으로 변경됩니다.

2.  **피드 탭**

-   피드 탭에서 작성일 기준 최신순으로 정렬된 모든 스크럼들을 볼 수 있습니다.
    
-   상단 탭에서 목록 또는 이미지로 원하는 조회 형식을 지정할 수 있습니다.
    
    -   목록 요소에는 아이콘, 작성자가 속한 팀 인원들, 제목, 그리고 중요 키워드 상위 3개가 적힌 태그가 포함됩니다.
        
        <img src="https://github.com/silverttthin/madcamp_week1/assets/83443857/246295f9-7aea-45d3-b8a7-4f650aa6285c" width="300">
        
        -   태그 추출은 `Translator` 모듈로 번역된 스크럼 게시글을 `Text Analysis` 모듈에 넣어 단어 단위로 추출한 값에서 상위 3개를 가져오는 과정을 거칩니다.
        -   추출 단어는 tags로 담아 `Wrap` 컨테이너에 담아 행 초과 시 줄이 바뀌게 설정했습니다.
            -   이 때 children 속성값으로 map 메서드를 사용해 각 요소를 태그 디자인이 적용된 `Container` 위젯이 담긴 리스트를 넣었습니다.
    -   갤러리 피드 페이지에서는 스크럼 이미지가 `MasonryGridView` 형식으로 나타납니다.
        
        <img src="https://github.com/silverttthin/madcamp_week1/assets/83443857/fb45c932-7b90-4c78-ad5d-b51e89b4fa99" width="300">
        
        -   각 이미지 `Grid` 는 배경 위에 이미지가 표시되는 방식입니다.
            -   배경색은 이미지의 `Dominant Color` 를 추출하여 사용합니다.
        -   사진 데이터는 사용자가 게시할 때 선택한 이미지를 사용합니다.
-   스크럼을 클릭 시 상세 페이지로 이동합니다.
    
    -   상세 페이지 UI는 아이콘, 한줄평, 팀원들과 작성일, 태그와 스크럼 내용으로 구성됩니다.
    -   스크럼 내용 텍스트는 `flutter_markdown`모듈이 마크다운으로 변환해 보여줍니다.

      <img src="https://github.com/silverttthin/madcamp_week1/assets/83443857/160eace1-1eaf-45c2-baed-63d269aff3c1" width="300">

3.  **트렌드 탭**

-   트렌드 탭은 다음 두 단어 그룹들을 단어 구름(사진 추가 `Word Cloud` ) 형식으로 보여줍니다.
    -   몰캠 트렌드
        
        <img src="https://github.com/silverttthin/madcamp_week1/assets/83443857/12555313-0a4e-4843-89c4-bce7c3d7cbed" width="200">
        
        -   모든 스크럼의 추출된 내용에서 가장 빈번하게 나오는 키워드
            -   `Translator` 와 `Text Analysis` 로 추출된 단어들을 빈도수에 따라 `Text Size` 를 달리하여 단어 구름을 만듭니다.
    -   실시간 트렌드
        
        <img src="https://github.com/silverttthin/madcamp_week1/assets/83443857/1b3eb1b9-9e9b-4e35-b7a3-ccbdc36f57d4" width="200">
        
        -   하단 `TextFormField`에 입력된 단어들을 위와 같은 방식으로 빈도수에 따라 단어 구름을 만듭니다.
            -   단어만 입력할 수 있도록 글자 길이는 5자로 제한합니다.

### Preview

----------
<table>
  <tr>
    <th>스크럼 추가 탭</th>
    <th>피드 탭</th>
    <th>트렌드 탭</th>
  </tr>
  <tr>
    <td align="center"><img src="https://github.com/silverttthin/madcamp_week1/assets/83443857/55f952bc-bcc4-4d59-9c27-7a5e62792cfd" width="300"></td>
    <td align="center"><img src="https://github.com/silverttthin/madcamp_week1/assets/83443857/1fdad6a4-d4e5-4c47-a720-5c8541b71180" width="300"></td>
    <td align="center"><img src="https://github.com/silverttthin/madcamp_week1/assets/83443857/6dc3597c-7979-46b2-adf5-ae79ea873412" width="300"></td>
  </tr>
</table>



### APK Download

----------

[![다운로드](https://img.shields.io/badge/다운로드-APK-blue)](https://drive.google.com/file/d/1xbrxmuOKiaA2Gvh0O6Yc8GHcCu5VWFdL/view?usp=sharing)
