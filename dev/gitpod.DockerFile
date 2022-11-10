# syntax=docker/dockerfile:1.4
FROM gitpod/workspace-base 

ENV TRIGGER_REBUILD=3
ENV DOCKER_BUILDKIT=1

ENV KUBEVERS="v1.23.10"

USER gitpod

RUN mkdir -p /home/gitpod/scripts 

ADD ./scripts /home/gitpod/scripts

RUN sudo chown -R gitpod:gitpod /home/gitpod/scripts && chmod -R +x /home/gitpod/scripts

ENV PATH="/home/gitpod/scripts:${PATH}"

RUN sudo -E /home/gitpod/scripts/prep_workspace