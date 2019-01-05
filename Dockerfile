FROM openjdk
ENV ALLURE_VERSION=2.7.0
ADD https://dl.bintray.com/qameta/generic/io/qameta/allure/allure/${ALLURE_VERSION}/allure-${ALLURE_VERSION}.tgz .
RUN tar -xvzf allure-${ALLURE_VERSION}.tgz && \
 rm *.tgz && \
 apt update && \
 apt install -y rsync && \
 apt clean
ENV PATH="/allure-${ALLURE_VERSION}/bin:$PATH"
COPY entrypoint.sh .
CMD sh entrypoint.sh

RUN mkdir allure-reports && chgrp -R 0 /allure-reports \
  && chmod -R g+rwX /allure-reports
VOLUME allure-reports
USER 1001
EXPOSE 8080
