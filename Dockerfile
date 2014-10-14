FROM phusion/passenger-ruby20

# Set correct environment variables.
ENV HOME /root

# Update the system
RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring main universe" >> /etc/apt/sources.list
RUN apt-get update

#   Build system and git.
RUN /build/utilities.sh

#   Ruby support.
RUN /build/ruby2.0.sh

#   Common development headers necessary for many Ruby gems,
#   e.g. libxml for Nokogiri.
RUN /build/devheaders.sh

#make home directory for webapp and add the gemfile
RUN mkdir /home/app/fullConnectAPI
ADD Gemfile /home/app/fullConnectAPI/
ADD Gemfile.lock /home/app/fullConnectAPI/
ADD start.sh /home/app/fullConnectAPI/

#bundle install
WORKDIR /home/app/fullConnectAPI
RUN bundle install

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*sudo

ENTRYPOINT ['./start.sh']
