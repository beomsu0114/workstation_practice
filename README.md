# 🚀 개발 워크스테이션 구축 실습 보고서

## 1. 프로젝트 개요
Docker, Linux CLI, Git을 활용하여 환경 재현성을 갖춘 개발 워크스테이션을 구축하고, 컨테이너화/포트 매핑/바인드 마운트/볼륨 영속성을 실습 및 검증하였습니다.

## 2. 실행 환경
- OS: macOS
- Shell: zsh
- Docker: v26+ (Docker Desktop)
- Git: v2.x

## 3. 수행 항목 체크리스트
- [x] 터미널 기본 조작 (pwd, mkdir, cd, echo, cat)
- [x] 파일 및 디렉토리 권한 변경 (chmod 755, 700)
- [x] Docker 설치 및 헬스체크 (docker --version, docker info)
- [x] hello-world 및 ubuntu 컨테이너 실행
- [x] 커스텀 Dockerfile 기반 NGINX 웹 서버 빌드
- [x] 포트 매핑(-p 8080:80) 및 브라우저/curl 접속 확인
- [x] 바인드 마운트(-v)를 통한 실시간 파일 수정 반영 검증
- [x] Docker 볼륨(volume)을 활용한 컨테이너 삭제 후 데이터 영속성 검증
- [x] Git 사용자 설정 (git config)

## 4. 실습 수행 로그 및 검증 결과 (Execution Logs)

### 4-1. Docker 헬스체크 & hello-world 실행
$ docker --version
Docker version 29.9.2, build a82e528

$ docker run --rm hello-world
Status: Downloaded newer image for hello-world:latest
Hello from Docker!
This message shows that your installation appears to be working correctly.

### 4-2. 커스텀 이미지 빌드 및 8080 포트 매핑 검증
$ docker build -t my-web-server:1.0 .
[+] Building 4.6s (7/7) FINISHED
 => naming to docker.io/library/my-web-server:1.0

$ docker run -d -p 8080:80 --name my-web my-web-server:1.0
$ curl http://localhost:8080
<h1>My Macbook Docker Web Server</h1>

### 4-3. 바인드 마운트(-v) 실시간 반영 검증 (8081 포트)
$ docker run -d -p 8081:80 -v $(pwd)/app:/usr/share/nginx/html --name bind-test nginx:alpine
$ echo "<h1>Content Changed on Macbook.</h1>" > app/index.html
$ curl http://localhost:8081
<h1>Content Changed on Macbook.</h1>

### 4-4. Docker 볼륨(mydata) 데이터 영속성 검증
$ docker volume create mydata
$ docker run -d --name test-container-1 -v mydata:/data ubuntu sleep infinity
$ docker exec test-container-1 bash -c "echo 'Saved Data' > /data/hello.txt"

# 첫 번째 컨테이너 삭제 후 새 컨테이너 연결
$ docker rm -f test-container-1
$ docker run -d --name test-container-2 -v mydata:/data ubuntu sleep infinity
$ docker exec test-container-2 cat /data/hello.txt
Saved Data

## 5. 핵심 이론 정리
1. 절대 경로 vs 상대 경로: 절대 경로는 루트(/) 기준 전체 경로, 상대 경로는 현재 위치(.) 기준 경로.
2. 권한 (755, 644): 755는 소유자(rwx), 그룹·기타(rx). 644는 소유자(rw), 그룹·기타(r).
3. 커스텀 이미지: Dockerfile 명령어를 통해 기본 이미지 위에 필요 설정 및 파일을 추가하여 만든 독립된 이미지.
4. 포트 매핑: 격리된 컨테이너 내부 포트를 호스트 PC 포트와 연결하여 외부 접속을 가능하게 만드는 설정.
5. Docker 볼륨: 컨테이너가 삭제되어도 데이터를 호스트에 영구 보존하는 지속성 저장소.
6. Git vs GitHub: Git은 로컬 버전 관리 도구, GitHub는 원격 소스코드 공유 및 협업 플랫폼.

## 6. 트러블슈팅
- 이슈: zsh에서 echo "<h1>...!" 실행 시 zsh: event not found: </h1> 에러 발생.
- 원인: zsh 쉘이 큰따옴표 안의 느낌표(!)를 명령 히스토리 이벤트로 해석함.
- 해결: 느낌표를 마침표(.)로 교체하거나 작은따옴표/이스케이프(\!)를 사용하여 정상 처리.
