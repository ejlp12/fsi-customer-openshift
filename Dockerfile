# This is the docker hub image
FROM ejlp12/entando-base-image-432

LABEL maintainer="Pietrangelo Masala <p.masala@entando.com>"

COPY filter-development-unix.properties /opt/entando/filter-development-unix.properties
COPY derby/ /opt/entando/derby/

WORKDIR /opt/entando

USER 1001

RUN git clone https://github.com/entando/fsi-onboarding-entando.git \
&& rm -f fsi-onboarding-entando/fsi-customer/src/main/filters/filter-development-unix.properties \
&& cp filter-development-unix.properties fsi-onboarding-entando/fsi-customer/src/main/filters/ \
&& mkdir -p fsi-onboarding-entando/fsi-customer/target/ \
&& cp -R derby/ fsi-onboarding-entando/fsi-customer/target/ \
&& chmod -R 777 /opt/entando/fsi-onboarding-entando/fsi-customer/


WORKDIR /opt/entando/fsi-onboarding-entando/fsi-customer

ENTRYPOINT [ "mvn", "-Dmaven.repo.local=/opt/entando/.m2/repository", "jetty:run" ]

EXPOSE 8080
