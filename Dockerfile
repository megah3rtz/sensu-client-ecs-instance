FROM debian:latest

RUN apt-get update && apt-get install wget curl gnupg apt-transport-https -y \
&& wget -q https://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | apt-key add - \
&& echo "deb     https://sensu.global.ssl.fastly.net/apt stretch main" | tee /etc/apt/sources.list.d/sensu.list \
&& apt-get update && apt-get install sensu ruby ruby-dev make gcc build-essential -y \
&& /opt/sensu/embedded/bin/gem install sensu-plugins-disk-checks --no-ri --no-rdoc \
&& /opt/sensu/embedded/bin/gem install sensu-plugins-memory-checks --no-ri --no-rdoc \
&& /opt/sensu/embedded/bin/gem install sensu-plugins-load-checks --no-ri --no-rdoc \
&& /opt/sensu/embedded/bin/gem install sensu-plugins-disk-checks --no-ri --no-rdoc \
&& /opt/sensu/embedded/bin/gem install sensu-plugins-cpu-checks --no-ri --no-rdoc \
&& /opt/sensu/embedded/bin/gem install sensu-plugins-http --no-ri --no-rdoc

# PEM files are from https://github.com/hiroakis/docker-sensu-server - THESE ARE NOT SECURE!
ADD key.pem /etc/sensu/ssl/key.pem
ADD cert.pem /etc/sensu/ssl/cert.pem
# PEM files are from https://github.com/hiroakis/docker-sensu-server - THESE ARE NOT SECURE!
ADD config.json /tmp/config.json
ADD client.json /tmp/client.json
ADD checks /tmp/checks/


ADD run-sensu-client.sh /opt/run-sensu-client.sh
RUN chmod 700 /opt/run-sensu-client.sh

ENTRYPOINT ["/opt/run-sensu-client.sh"]
