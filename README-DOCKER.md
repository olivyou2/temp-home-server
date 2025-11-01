# tempathome_server를 Docker 이미지로 빌드하고 레지스트리에 푸시하는 방법

아래는 프로젝트 루트에서 실행 가능한 주요 명령과 예시입니다.

1) 이미지 빌드

Windows (cmd.exe)에서 프로젝트 루트에서 실행:

```bat
docker build -t <your-registry-or-name>/tempathome_server:latest .
```

예: Docker Hub에 올릴 예정이라면 이미지 이름을 레지스트리 경로로 지정하세요.

2) 로컬 실행 (H2 DB 파일을 호스트와 공유하려면 볼륨 마운트)

```bat
docker run --rm -p 8080:8080 -v %cd%/data:/app/data <your-registry-or-name>/tempathome_server:latest
```

3) 레지스트리에 푸시 (예: Docker Hub)

```bat
docker tag <your-registry-or-name>/tempathome_server:latest mydockerhubuser/tempathome_server:latest
docker push mydockerhubuser/tempathome_server:latest
```

배포 관련 참고
- Dockerfile은 multi-stage로 Gradle 빌드와 작은 JRE 런타임을 사용합니다.
- 로컬 H2 DB 파일(`data/`)은 .dockerignore에 의해 이미지에 포함되지 않으므로, 컨테이너 실행 시 호스트 디렉토리를 마운트하세요.

배치 스크립트 예시는 `build-and-push.bat`를 참고하세요.
