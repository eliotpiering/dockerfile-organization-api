FROM phusion/passenger-ruby20:0.9.14

# Set correct environment variables.
ENV HOME /root

# Update the system
RUN apt-get update

# Use baseimage-docker init process
CMD ["/sbin/my_init"]

#   Build system and git.
RUN /build/utilities.sh

#   Ruby support.
RUN /build/ruby2.0.sh

#make home directory for webapp and add the gemfile
RUN mkdir /home/app/fullConnectAPI
ADD Gemfile /home/app/fullConnectAPI/
ADD Gemfile.lock /home/app/fullConnectAPI/
ADD start.sh /home/app/fullConnectAPI/

#bundle install
WORKDIR /home/app/fullConnectAPI
RUN bundle install

# clean up apt when done.
run apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*sudo

ENTRYPOINT ['/home/app/fullConnectAPI/start.sh']
