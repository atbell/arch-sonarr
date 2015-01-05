FROM atbell/arch-base
MAINTAINER atbell

# install application
#####################

# update package databases for arch
RUN pacman -Sy --noconfirm

# run packer to install application
RUN packer -S sonarr --noconfirm

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# map /data to host defined data path (used to store downloads or use blackhole)
VOLUME /data

# map /media to host defined media path (used to read/write to media library)
VOLUME /media

# expose port for http
EXPOSE 8989

# set permissions
#################

# change owner
RUN chown -R nobody:users /usr/sbin/sonarr

# set permissions
RUN chmod -R 775 /usr/bin/sonarr

# create base dir for sonarr config
RUN mkdir /.config

# chown sonarr default config
RUN chown nobody:users /.config -R

# create symlink from default sonarr config dir to /config
RUN ln -s /config /.config/sonarr

# add conf file
###############

ADD sonarr.conf /etc/supervisor/conf.d/sonarr.conf

# cleanup
#########

# completely empty pacman cache folder
RUN pacman -Scc --noconfirm

# remove temporary files
RUN rm -rf /tmp/*

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]
