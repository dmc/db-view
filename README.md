## Overview
- database utility

## Build
```bash
./gradlew clean build
```
## Run on docker
```bash
docker compose up -d
```

## Deploy war file
deploy `build/libs/db-view.war` file to j2ee container

## customize preset of database parameters
- require rebuild
  - modify preset array in `src/main/webapp/javascript/preset.js`

## customize css 
- require rebuild
  - add css file to `src/main/webapp/css`
  - new css will appear in theme select box.