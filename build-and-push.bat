@echo off
REM 빌드, 도커 이미지 생성 및 (옵션) 푸시 스크립트
REM 사용법: build-and-push.bat <image-name> [push]

if "%~1"=="" (
  echo Usage: %~nx0 ^<image-name^> [push]
  echo Example: %~nx0 mydockerhubuser/tempathome_server:latest push
  exit /b 1
)

set IMAGE_NAME=%~1
set PUSH_FLAG=%~2

REM JAVA_HOME 확인
if not defined JAVA_HOME (
  echo WARNING: JAVA_HOME not set. Gradle wrapper may fail if java is not in PATH.
) else (
  echo Using JAVA_HOME=%JAVA_HOME%
)

echo Running Gradle build...
"%~dp0gradlew.bat" clean bootJar
if errorlevel 1 (
  echo Gradle build failed. Aborting.
  exit /b 1
)

echo Building Docker image %IMAGE_NAME% ...
docker build -t %IMAGE_NAME% .
if errorlevel 1 (
  echo Docker build failed. Aborting.
  exit /b 1
)

if /i "%PUSH_FLAG%"=="push" (
  echo Pushing %IMAGE_NAME% ...
  docker push %IMAGE_NAME%
  if errorlevel 1 (
    echo Docker push failed.
    exit /b 1
  )
)

echo Done.

