FROM ubuntu:24.04

WORKDIR /app

RUN apt-get update \
    && apt-get install -y wget gnupg lsb-release curl unzip

RUN apt-get update \
    && apt-get install -y php-cli php-zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN composer --version

RUN composer init --no-interaction --name="beganovich/github-50" \
    && composer require beganovich/snappdf

RUN composer show beganovich/snappdf

ENTRYPOINT [ "php" ]