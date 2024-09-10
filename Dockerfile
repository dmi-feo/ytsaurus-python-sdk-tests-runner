FROM ghcr.io/ytsaurus/ytsaurus:hotfix-23.2 AS built_yt

FROM ubuntu:22.04 AS test_image

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y python3 python3-pip && apt-get clean

RUN mkdir /source

COPY --from=built_yt /tmp/ytsaurus_python /workdir/python_build
RUN for package in client yson local native_driver; \
  do \
    dist_dir="/workdir/python_build/ytsaurus_${package}_dist"; \
    wheel_path="${dist_dir}/$(ls ${dist_dir} | grep "^ytsaurus_$package.*whl$")"; \
    python3 -m pip install ${wheel_path}; \
  done

COPY --from=built_yt /usr/bin/ytserver-all /workdir/yt/yt/server/all/ytserver-all

COPY ./yt/yt/scripts /workdir/scripts

RUN cp -r /workdir/python_build/yt_* /source

RUN python3 -m pip install -r ./workdir/scripts/pytest_requirements.txt
RUN python3 -m pip install "pytest-jupyter[server]"

ENV YT_BUILD_ROOT=/workdir
ENV YT_TESTS_SANDBOX=/tmp
ENV YTSERVER_ALL_PATH=/workdir/yt/yt/server/all/ytserver-all
