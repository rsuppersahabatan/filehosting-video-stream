# FileHosting-VIDEO-STREAM (FHV Stream)

### (still under development)
FileHosting-VIDEO-STREAM (FHV Stream) is a file hosting script, but focus on video sharing and embed. 
Don't waste your money buying scripts with similar features for thousands of dollars, just use this script and it costs nothing.

FHV Stream have features:
- File Upload (basically only from file, but next time added upload from URL and more)
- File Management (CRUD)
- Support Nested Folder (Without limit)
- Multi Storage Server (yes, not only one, your are free to create many numbers of server, also support for Dropbox, Google drive, Box, Rackspace, Google Cloud Storage, Azure Storage, IBM Storage and many more)
- Embed Code (copy and paste to your sites, just easy)
- Video Download Page
- File Statistic (only count view and download)


**Example of nested folder**
```
/folder-a
    /subfolder-a
        /subsubfolder-a
            /subsubsubfolder-a
            /subsubsubfolder-b
                ...
        /subsubfolder-b
        /subsubfolder-c
        /subsubfolder-d
    /subfolder-b
    /subfolder-c
/folder-b
/folder-c
/folder-d
/folder-e
...
```

**Screeshot App**


![alt text](https://github.com/fatkulnurk/filehosting-video-stream/raw/main/docs/images/1-home.png "Home")
---
![alt text](https://github.com/fatkulnurk/filehosting-video-stream/raw/main/docs/images/2-dashboard.png "Dashboard")
---
![alt text](https://github.com/fatkulnurk/filehosting-video-stream/raw/main/docs/images/3-myfiles.png "my files")
---
![alt text](https://github.com/fatkulnurk/filehosting-video-stream/raw/main/docs/images/4-upload.png "upload")
---
![alt text](https://github.com/fatkulnurk/filehosting-video-stream/raw/main/docs/images/5-show-page.png "show page")
---
![alt text](https://github.com/fatkulnurk/filehosting-video-stream/raw/main/docs/images/6-stream.png "stream")
---

**TO-DO**

- [x] File Upload
- [x] Create Unlimited Nested Folder
- [x] Manage Folder (CRUD)
- [x] File Manager (CRUD)
- [x] Multi Storage Server
- [x] Download Page
- [x] Embed Video Script (disable download and right click)
- [x] Expired Direct Download Link (default 24 hours)
- [x] Expired Streaming Video Direct Link (default 24 hours)
- [ ] Auto Generate Thumbnail
- [ ] Statistic Download
- [ ] Auto Convert To MP4
- [ ] Reward System
- [ ] Affiliate System
- [ ] Custom Advertising
- [ ] Upload Via URL
- [ ] Upload Via COPY
- [ ] Upload Via FTP
- [ ] Developer Api

## Install and Usage FHV Stream
```
Comming soon (same with laravel instalation)
```

### Install with Docker-Compose

```
$ cp .env.example .env

# Sesuaikan .env:
#   DB_HOST=mysql, DB_PORT=3306, DB_DATABASE=laravel, DB_USERNAME=laravel, DB_PASSWORD=secret
#   REDIS_HOST=redis, REDIS_PORT=6379

docker compose up -d --build
docker compose exec app php artisan key:generate
docker compose exec app php artisan migrate
```

#### Pertama kali / setiap kali ubah asset
> docker compose run --rm node npm install
> docker compose run --rm node npm run dev

#### Watch mode (rebuild saat file berubah)
> docker compose run --rm node npm run watch

#### Production build
> docker compose run --rm node npm run prod

#### Atau pakai service yang sudah didefinisikan (otomatis install + dev)
> docker compose up node

#### Production 

# 1. Siapkan .env (BUKAN .env.example) di server
cat > .env <<'EOF'
APP_NAME=Filevideo
APP_ENV=production
APP_KEY=                 # akan di-generate
APP_DEBUG=false
APP_URL=https://filevideo.example.com

LOG_CHANNEL=stack

DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=filevideo
DB_USERNAME=filevideo
DB_PASSWORD=GANTI_INI_PASSWORD_KUAT
DB_ROOT_PASSWORD=GANTI_INI_ROOT_KUAT

BROADCAST_DRIVER=log
CACHE_DRIVER=redis
QUEUE_CONNECTION=redis
SESSION_DRIVER=redis
SESSION_LIFETIME=120

REDIS_HOST=redis
REDIS_PASSWORD=GANTI_INI_REDIS_KUAT
REDIS_PORT=6379

APP_PORT=80
EOF

# 2. Build & start
docker compose -f docker-compose.prod.yml up -d --build

# 3. Setup awal
docker compose -f docker-compose.prod.yml exec app php artisan key:generate --force
docker compose -f docker-compose.prod.yml exec app php artisan migrate --force
docker compose -f docker-compose.prod.yml exec app php artisan storage:link
docker compose -f docker-compose.prod.yml exec app php artisan config:cache
docker compose -f docker-compose.prod.yml exec app php artisan route:cache
docker compose -f docker-compose.prod.yml exec app php artisan view:cache

# 4. Cek
docker compose -f docker-compose.prod.yml ps
docker compose -f docker-compose.prod.yml logs -f

