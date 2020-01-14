FROM abernix/meteord:node-8.16.3-base

# Install Chrome
RUN apt-get update && apt-get install -y wget --no-install-recommends \
&& wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
&& sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
&& apt-get update \
&& apt-get install -y google-chrome-unstable --no-install-recommends \
&& rm -rf /var/lib/apt/lists/* \
&& apt-get purge --auto-remove -y curl \
&& rm -rf /src/*.deb

# Install missing fonts for rendering contract
RUN apt-get update && apt-get install -y ttf-freefont fonts-lato

# See https://crbug.com/795759
RUN apt-get update && apt-get install -yq libgconf-2-4

# It's a good idea to use dumb-init to help prevent zombie chrome processes.
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init
