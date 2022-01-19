> 이 저장소는 Oct 8 Fri, 2021 기준으로 완성되었습니다

# TITLE
목적 : 터미널, 수학함수를 통한 그림(?) 그리기
사용언어 : lua (with luv / luajit)

# school_graphProgram
학교 정보시간 과제입니다 +a 대회 출전 작품입니다

![title](/images/star.png)
![title](/images/heart.png)

실행 방법 : 이 깃 repo 다운로드 받고 해당 다운받은 디렉터리에서 cmd 를 열고  
graph 입력후 엔터 (graph.exe), 그다음 프로그램이 띄워주는 설명에 따라 사용하면 됩니다 (설명은 프로그램 안에 내장)  

# 사용된 라이브러리
luvit - fs lib : https://github.com/luvit/luvit/blob/master/deps/fs.lua  
luvi - build system : https://github.com/luvit/luvi  

# 필요에 따라 직접 luvi 를 이용하는 경우
```sh
luvi app -o graph.exe
```
다음 명령어를 이용하면 graph.exe 파일로 빌드됩니다, 필요에 따라 리눅스, 맥 용으로도 빌드할 수 있습니다.
빌더 luvi 를 얻으러면 [luvit-bin](https://github.com/truemedian/luvit-bin) 을 참고해주세요
