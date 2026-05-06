FROM nousresearch/hermes-agent:latest
ENV HERMES_DASHBOARD=1 HERMES_DASHBOARD_HOST=0.0.0.0 HERMES_DASHBOARD_PORT=8080

# Write startup script that injects env vars into Hermes config
COPY entrypoint-wrapper.sh /opt/hermes/entrypoint-wrapper.sh
RUN chmod +x /opt/hermes/entrypoint-wrapper.sh

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["/opt/hermes/entrypoint-wrapper.sh"]
