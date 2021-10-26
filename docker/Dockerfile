FROM fedora:34
# Set a useful default locale
RUN echo "export LANG=en_US.UTF-8" > /opt/export_LANG.sh
RUN echo "export LANGUAGE=en_US.UTF-8" >> /opt/export_LANG.sh
RUN echo "export LC_ALL=en_US.UTF-8" >> /opt/export_LANG.sh
ENV BASH_ENV=/opt/export_LANG.sh \
    ENV=/opt/export_LANG.sh \
    PROMPT_COMMAND="source /opt/export_LANG.sh"

ARG user
ARG userid
ARG dockergroupid

RUN groupadd -r docker -g$dockergroupid && useradd -d "/home/$user" -u $userid -U -G docker -m -s /bin/bash $user

# # Prerequisites for VSCodium
# RUN rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
# RUN printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" | tee -a /etc/yum.repos.d/vscodium.repo

RUN dnf clean all && \
    dnf install \
    vim \
    firefox \
    wget \
    git \
    nodejs \
    npm \
    gtk2 \             
    libXScrnSaver \    
    libsecret \        
    libwayland-server \
    libxkbfile \       
    mesa-libgbm -y &&\
    dnf clean all


RUN mkdir /home/$user/codium

#RUN wget -O - https://github.com/VSCodium/vscodium/releases/download/1.61.2/VSCodium-linux-x64-1.61.2.tar.gz | tar zxf - -C /home/$user/vscodium

# RUN wget https://github.com/VSCodium/vscodium/releases/download/1.61.2/VSCodium-linux-x64-1.61.2.tar.gz -O - | tar -xzvf - -C /home/$user/vscodium

RUN wget https://github.com/VSCodium/vscodium/releases/download/1.61.2/VSCodium-linux-x64-1.61.2.tar.gz -O /tmp/vscodium.tar.gz
RUN tar -xzvf /tmp/vscodium.tar.gz -C /home/$user/codium

COPY ./entrypoint.sh /home/$user/
RUN chmod a+x /home/$user/entrypoint.sh

RUN touch /home/$user/.gitconfig

RUN chown $user:$user /home/$user -R

USER $user

CMD  /home/$user/entrypoint.sh