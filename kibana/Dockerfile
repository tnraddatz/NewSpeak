FROM kibana:5.6.14

RUN apt-get update -yqq \
  && apt-get install -yqq netcat

COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

ADD kibana.yml /opt/kibana/config/

CMD ["/tmp/entrypoint.sh"]
