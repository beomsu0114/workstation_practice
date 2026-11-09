# Docker 개발 워크스테이션 구축 결과물

## 1) 프로젝트 개요
이 저장소는 CLI(터미널) 기반으로 개발 워크스테이션을 구성하고,  
Docker 설치/점검, 컨테이너 실행, Dockerfile 기반 커스텀 이미지 제작, 포트 매핑, 바인드 마운트, Docker 볼륨 영속성, Git/GitHub 연동까지 수행한 결과를 정리한 문서이다.

### 미션 목표
- 터미널 기본 조작 수행 및 로그 기록
- 파일/디렉토리 권한 확인 및 변경 실습
- Docker 설치 및 기본 운영 명령 검증
- `hello-world`, `ubuntu` 컨테이너 실행 실습
- Dockerfile 기반 커스텀 웹 서버 이미지 제작
- 포트 매핑 접속 확인
- 바인드 마운트와 볼륨 영속성 검증
- Git 설정 및 GitHub/VSCode 연동 증거 기록
- 트러블슈팅 사례 2건 이상 정리

---

## 2) 실행 환경

- OS: macOS 27.2
- Shell: zsh
- Terminal: Terminal
- Docker Version: Docker version 29.9.2, build a82e528
- Git Version: git version 2.54.0 (Apple Git-157)

### 환경 확인 명령
```bash
uname -a
echo $SHELL
docker --version
docker info
git --version
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

---

## 3) 수행 항목 체크리스트

- [x] 터미널 기본 조작 및 폴더 구성
- [x] 파일 권한 변경 실습
- [x] 디렉토리 권한 변경 실습
- [x] Docker 설치 및 점검
- [x] hello-world 실행
- [x] ubuntu 컨테이너 실행 및 내부 명령 수행
- [x] attach / exec 차이 관찰 및 정리
- [x] Docker 기본 운영 명령 수행
- [x] Dockerfile 직접 작성
- [x] 커스텀 이미지 빌드 및 실행
- [x] 포트 매핑 접속 확인
- [x] 바인드 마운트 반영 확인
- [x] Docker 볼륨 영속성 검증
- [x] Git 설정 및 `git config --list` 확인
- [x] GitHub 원격 저장소 연동
- [x] VSCode GitHub 연동 확인
- [x] 트러블슈팅 2건 이상 기록
- [x] 민감정보 마스킹 점검

---

## 4) 저장소 구조

```text
.
├── README.md
├── Dockerfile
├── app/
│   └── index.html
├── assets/
│   ├── browser-8080.png
│   ├── bind-before.png
│   ├── bind-after.png
│   ├── volume-before.png
│   ├── volume-after.png
│   ├── vscode-github-login.png
│   ├── vscode-source-control.png
│   ├── terminal-build-run.png
│   └── troubleshooting-01.png
└── backup/
    └── <백업파일명>
```

### 구성 기준
- `README.md` : 전체 수행 내용, 검증 방법, 결과 정리
- `Dockerfile` : 커스텀 이미지 정의
- `app/` : 웹 서버가 제공할 정적 파일
- `assets/` : 스크린샷 증거
- `backup/` : 볼륨 백업 파일 저장

---

## 5) 검증 방법 요약

| 검증 항목 | 확인 명령 | 기대 결과 | 결과 위치 |
|---|---|---|---|
| 현재 위치 확인 | `pwd` | 작업 경로 출력 | 6장 |
| 숨김 파일 포함 목록 | `ls -la` | 파일/디렉토리 목록 출력 | 6장 |
| 권한 변경 | `chmod`, `ls -l`, `ls -ld` | 권한 전/후 비교 가능 | 7장 |
| Docker 설치 | `docker --version` | Docker 버전 출력 | 8장 |
| Docker 데몬 상태 | `docker info` | 서버 정보 출력 | 8장 |
| hello-world 실행 | `docker run --rm hello-world` | 성공 메시지 출력 | 9장 |
| ubuntu 컨테이너 | `docker exec` | 내부 명령 실행 확인 | 9장 |
| 운영 명령 | `docker images`, `docker ps -a`, `docker logs`, `docker stats` | 이미지/컨테이너/로그/리소스 확인 | 10장 |
| 커스텀 이미지 빌드 | `docker build` | 빌드 성공 | 11장 |
| 포트 매핑 | `curl http://localhost:8080` | HTML 응답 확인 | 12장 |
| 브라우저 접속 | 브라우저 + 주소창 | 포트 포함 접속 증거 | 12장 |
| 바인드 마운트 | 파일 수정 전/후 `curl` | 응답 변경 확인 | 13장 |
| 볼륨 영속성 | 삭제 전/후 `cat /data/hello.txt` | 데이터 유지 확인 | 14장 |
| Git 설정 | `git config --list` | 사용자 정보/기본 브랜치 확인 | 15장 |
| 원격 저장소 연결 | `git remote -v` | 원격 URL 확인 | 15장 |
| GitHub Push | `git push origin main` | 푸시 성공 | 15장 |

---

## 6) 터미널 기본 조작 로그

### 수행 명령
```bash
pwd
ls -la
mkdir -p practice/app practice/assets practice/backup
cd practice
pwd
touch notes.txt
cp notes.txt notes-copy.txt
mv notes-copy.txt notes-renamed.txt
echo "hello terminal" > notes.txt
cat notes.txt
rm notes-renamed.txt
ls -la
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

### 설명
- `pwd` : 현재 작업 위치 확인
- `ls -la` : 숨김 파일 포함 목록 확인
- `mkdir -p` : 디렉토리 생성
- `touch` : 빈 파일 생성
- `cp` : 파일 복사
- `mv` : 파일 이동 또는 이름 변경
- `cat` : 파일 내용 확인
- `rm` : 파일 삭제

---

## 7) 권한 실습 및 증거 기록

## 7-1. 파일 권한 변경

### 수행 명령
```bash
touch permission-file.txt
ls -l permission-file.txt
chmod 644 permission-file.txt
ls -l permission-file.txt
chmod 755 permission-file.txt
ls -l permission-file.txt
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

### 해석
- `644` : 소유자 `rw-`, 그룹 `r--`, 기타 `r--`
- `755` : 소유자 `rwx`, 그룹 `r-x`, 기타 `r-x`

---

## 7-2. 디렉토리 권한 변경

### 수행 명령
```bash
mkdir permission-dir
ls -ld permission-dir
chmod 700 permission-dir
ls -ld permission-dir
chmod 755 permission-dir
ls -ld permission-dir
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

### 해석
- 디렉토리는 실행 권한(`x`)이 있어야 내부 진입(`cd`)이 가능하다.
- 파일과 디렉토리는 권한 의미가 다르기 때문에 둘 다 실습했다.

### 숫자 권한 계산
- 읽기(`r`) = 4
- 쓰기(`w`) = 2
- 실행(`x`) = 1
- 예: `7 = 4 + 2 + 1`, `5 = 4 + 1`

---

## 8) Docker 설치 및 기본 점검

### 8-1. Docker 버전 확인
```bash
docker --version
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

### 8-2. Docker 데몬 동작 확인
```bash
docker info
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

### 설명
- `docker --version` 으로 Docker CLI 버전을 확인했다.
- `docker info` 로 Docker 데몬이 정상 동작하는지 확인했다.

---

## 9) 컨테이너 실행 실습

## 9-1. hello-world 실행

### 수행 명령
```bash
docker run --rm hello-world
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

---

## 9-2. ubuntu 컨테이너 실행 및 내부 명령 수행

### 수행 명령
```bash
docker run -dit --name ubuntu-test ubuntu bash
docker exec ubuntu-test ls /
docker exec ubuntu-test sh -c "echo hello from ubuntu container"
docker exec ubuntu-test sh -c "echo sample > /tmp/test.txt && cat /tmp/test.txt"
docker ps -a
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

### 설명
- `docker run -dit` : ubuntu 컨테이너를 백그라운드에서 실행
- `docker exec` : 실행 중인 컨테이너 내부에서 명령 수행
- `ls`, `echo`, `cat` 으로 컨테이너 내부 동작을 확인

---

## 9-3. attach 와 exec 차이 관찰

### 실습 예시
```bash
docker run -dit --name ubuntu-attach ubuntu bash
docker attach ubuntu-attach
```

### 관찰
- `attach` 는 실행 중인 컨테이너의 **주 프로세스(stdin/stdout)** 에 직접 연결한다.
- `attach` 상태에서 `exit` 하면 주 프로세스인 `bash` 가 종료되어 컨테이너도 종료될 수 있다.

### 실습 예시
```bash
docker run -dit --name ubuntu-exec ubuntu bash
docker exec -it ubuntu-exec bash
```

### 관찰
- `exec` 는 실행 중인 컨테이너 안에서 **새로운 프로세스**를 실행한다.
- `exec` 로 들어간 셸에서 `exit` 해도, 메인 프로세스가 살아 있으면 컨테이너는 계속 실행된다.

### 정리
- `attach` : 메인 프로세스에 직접 연결
- `exec` : 별도 명령 실행
- 일반적인 점검/운영에는 `exec` 가 더 안전하고 편리하다

---

## 10) Docker 기본 운영 명령 수행

### 수행 명령
```bash
docker images
docker ps
docker ps -a
docker logs ubuntu-test
docker stats --no-stream
```

> 웹 서버 컨테이너 실행 후에는 아래도 확인
```bash
docker logs my-web
docker stats --no-stream my-web
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

### 설명
- `docker images` : 로컬 이미지 목록 확인
- `docker ps` : 실행 중인 컨테이너 확인
- `docker ps -a` : 종료된 컨테이너 포함 전체 확인
- `docker logs` : 컨테이너 로그 확인
- `docker stats` : CPU/메모리 등 리소스 사용량 확인

---

## 11) Dockerfile 기반 커스텀 이미지 제작

## 11-1. 선택한 기존 베이스 이미지
이번 실습에서는 **웹 서버 베이스 이미지 방식(A)** 을 선택했다.

- 선택 베이스 이미지: `nginx:alpine`
- 선택 이유:
  - 가볍고 빠르게 실행 가능
  - 정적 웹 페이지 배포 실습에 적합
  - 포트 매핑, 바인드 마운트, 볼륨 검증에 활용하기 쉬움

---

## 11-2. 커스텀 포인트와 목적

1. `nginx:alpine` 사용  
   - 경량 웹 서버 환경 구성

2. `app/` 디렉토리의 정적 파일 복사  
   - 내가 만든 웹 페이지를 기본 nginx 페이지 대신 제공

3. 포트 매핑으로 브라우저 접속 검증  
   - 컨테이너 내부 서비스가 호스트에서 접근 가능한지 확인

---

## 11-3. 웹 서버 소스코드

파일: `app/index.html`

```html
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Docker Web Server</title>
</head>
<body>
  <h1>My Docker Web Server</h1>
  <p>Served by nginx container</p>
</body>
</html>
```

---

## 11-4. Dockerfile

```Dockerfile
FROM nginx:alpine
COPY app/ /usr/share/nginx/html/
```

### 설명
- `FROM nginx:alpine` : nginx 기반 이미지 사용
- `COPY app/ /usr/share/nginx/html/` : 웹 루트에 정적 파일 복사

---

## 11-5. 빌드 및 실행

### 빌드 명령
```bash
docker build -t my-web-server:1.0 .
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

### 컨테이너 실행
```bash
docker run -d -p 8080:80 --name my-web my-web-server:1.0
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

### 빌드/실행 스크린샷
- `assets/terminal-build-run.png`

![terminal-build-run](assets/terminal-build-run.png)

---

## 12) 포트 매핑 및 접속 증거

### 접속 확인 명령
```bash
curl http://localhost:8080
curl -I http://localhost:8080
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

### 설명
- `-p 8080:80` 옵션으로 호스트의 `8080` 포트를 컨테이너의 `80` 포트와 연결했다.
- `curl` 응답을 통해 웹 페이지가 정상 제공되는 것을 확인했다.

### 브라우저 접속 증거
- 주소창에 `http://localhost:8080` 이 보이는 화면 첨부
- 파일: `assets/browser-8080.png`

![browser-8080](assets/browser-8080.png)

---

## 13) 바인드 마운트 반영 확인

### 실행 명령
```bash
docker run -d -p 8081:80 \
  -v $(pwd)/app:/usr/share/nginx/html \
  --name bind-test nginx:alpine
```

> macOS/Linux 기준 예시이며, 셸 환경에 따라 경로 표기 방식이 다를 수 있다.

### 변경 전 확인
```bash
curl http://localhost:8081
```

### 호스트 파일 수정
```bash
echo "<h1>Bind Mount Updated</h1>" > app/index.html
```

### 변경 후 확인
```bash
curl http://localhost:8081
```

### 실행 결과
```bash
<변경 전/후 실제 출력 붙여넣기>
```

### 설명
- 호스트 경로 `$(pwd)/app` 와 컨테이너 경로 `/usr/share/nginx/html` 을 연결했다.
- 호스트에서 파일을 수정하자 컨테이너 내부 웹 응답이 즉시 바뀌는 것을 확인했다.
- 바인드 마운트는 개발 중 빠른 수정/반영에 유리하다.

### 스크린샷
- 변경 전: `assets/bind-before.png`
- 변경 후: `assets/bind-after.png`

![bind-before](assets/bind-before.png)
![bind-after](assets/bind-after.png)

---

## 14) Docker 볼륨 영속성 검증

### 14-1. 볼륨 생성
```bash
docker volume create mydata
docker volume inspect mydata
```

### 실행 결과
```bash
<실제 출력 붙여넣기>
```

### 14-2. 컨테이너에 볼륨 연결 후 데이터 저장
```bash
docker run -d --name vol-test -v
