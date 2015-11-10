FROM netcapsule/base-browser

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update && apt-get install -y \
    google-chrome-stable libnss3-tools \
    && rm -rf /var/lib/apt/lists/*

USER browser

COPY flux-apps /home/browser/.fluxbox/apps
RUN sudo chown browser:browser -R /home/browser/.fluxbox

COPY run.sh /app/run.sh

RUN sudo chmod a+x /app/run.sh

WORKDIR /home/browser

CMD /app/entry_point.sh /app/run.sh


