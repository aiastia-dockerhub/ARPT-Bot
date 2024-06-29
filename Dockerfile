FROM ubuntu

# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo 'Asia/Shanghai' >/etc/timezone
RUN apt update && sudo apt upgrade -y
# 更新并安装所需的包
RUN 
    apt install -y \
        wget \
        git \
        curl \
        unzip \
        python3 \
        python3-dev \
        python3-pip \
        python3-pillow \
        tzdata \
        aria2 \
        nginx \
        ffmpeg \
        gcc \
        libffi-dev \
        libssl-dev \
        gconf-service \
        libasound2 \
        libatk1.0-0 \
        libatk-bridge2.0-0 \
        libc6 \
        libcairo2 \
        libcups2 \
        libdbus-1-3 \
        libexpat1 \
        libfontconfig1 \
        libgcc1 \
        libgconf-2-4 \
        libgdk-pixbuf2.0-0 \
        libglib2.0-0 \
        libgtk-3-0 \
        libnspr4 \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libstdc++6 \
        libx11-6 \
        libx11-xcb1 \
        libxcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxrandr2 \
        libxrender1 \
        libxss1 \
        libxtst6 \
        ca-certificates \
        fonts-liberation \
        libappindicator1 \
        libnss3 \
        lsb-release \
        xdg-utils \
        libxml2-dev \
        libxslt-dev

# 安装 Python 包
RUN pip3 install --upgrade pip && \
    pip3 install -U pyrogram tgcrypto telegraph aria2p mutagen requests yt-dlp apscheduler pyromod psutil nest_asyncio pyppeteer nhentai beautifulsoup4 lxml

# 拷贝文件和设置权限
COPY root /
COPY config /root/.aria2/
COPY nginx.conf /etc/nginx/
COPY /index.html /index/
COPY bot /bot
COPY /config/upload.sh /
COPY /start.sh /

RUN chmod -R 0777 /bot /root/.aria2 /upload.sh /start.sh && \
    chmod 777 /install.sh && \
    bash install.sh

# 设置启动命令
CMD wget https://raw.githubusercontent.com/666wcy/ARPT-Bot/main/start.sh -O start.sh && chmod 0777 start.sh && bash start.sh
