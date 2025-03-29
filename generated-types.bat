@echo off
SETLOCAL

:: Получаем текущую директорию, где находится .bat файл
set "SCRIPT_DIR=%~dp0"
set "NODE_MODULES_PATH=%SCRIPT_DIR%node_modules"

:: Проверяем наличие node_modules
if not exist "%NODE_MODULES_PATH%" (
    echo Error: The "node_modules" folder is missing.
    echo Please run "npm install" or "yarn install" first.
    exit /b 1
)

:: Запускаем protoc с динамическим путём
protoc ^
  --plugin=protoc-gen-ts_proto="%NODE_MODULES_PATH%\.bin\protoc-gen-ts_proto.cmd" ^
  --ts_proto_out=./src/proto/generated ^
  --ts_proto_opt=outputServices=grpc-js,nestJs=true,addGrpcMetadata=true,addNestjsRestParameter=true,returnObservable=false ^
  -I=./src/proto ^
  ./src/proto/auth.proto

ENDLOCAL
