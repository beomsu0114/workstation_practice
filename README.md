# 🚀 개발 워크스테이션 구축 실습 보고서

## 1. 프로젝트 개요
Docker, Linux CLI, Git을 활용하여 환경 재현성을 갖춘 개발 워크스테이션을 구축하고, 컨테이너화/포트 매핑/바인드 마운트/볼륨 영속성을 실습 및 검증하였습니다.

## 2. 실행 환경
- **OS**: macOS
- **Shell**: zsh
- **Docker**: v26+ (Docker Desktop)
- **Git**: v2.x

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
```text
$ docker --version
Docker version 29.9.2, build a82e528

$ docker run --rm hello-world
Status: Downloaded newer image for hello-world:latest
Hello from Docker!
This message shows that your installation appears to be working correctly.

