FROM nousresearch/hermes-agent:latest
ENV HERMES_DASHBOARD=1 HERMES_DASHBOARD_HOST=0.0.0.0 HERMES_DASHBOARD_PORT=8080
# Remove the anonymous VOLUME declaration from base image so Coolify's 
# persistent storage is used instead of a disposable anonymous volume
COPY entrypoint-wrapper.sh /opt/hermes/entrypoint-wrapper.sh
RUN chmod +x /opt/hermes/entrypoint-wrapper.sh
ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["/opt/hermes/entrypoint-wrapper.sh"]
