ARG TENSORFLOW_NOTEBOOK_TAG=latest
FROM jupyter/tensorflow-notebook:$TENSORFLOW_NOTEBOOK_TAG

# https://github.com/jupyter/docker-stacks/issues/678#issuecomment-406859403
RUN unset SUDO_GID && \
    unset SUDO_COMMAND && \
    unset SUDO_USER && \
    unset SUDO_UID

RUN conda install --quiet --yes -c pytorch \
    'pytorch=1.0.0' \
    'torchvision=0.2.1' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN conda install --quiet --yes \
    'pip' \
    'requests' \
    'psycopg2' \
    'plotly=3.4.1' \
    'boto3' \
    'black' \
    'nbconvert' && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN pip install --no-cache-dir \
    'git+https://github.com/bjornaa/py2nb.git' \
    'schedule' \
    'blackcellmagic' && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
