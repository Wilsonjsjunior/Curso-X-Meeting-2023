FROM biocontainers/biocontainers:v1.1.0_cv2

ARG bwa_version=0.7.17

RUN conda install bwa=${bwa_version}
WORKDIR /data/
CMD ["bwa"]