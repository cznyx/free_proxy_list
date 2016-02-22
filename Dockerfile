
FROM debian:latest
MAINTAINER contact@samuel-berthe.fr

RUN apt-get update && apt-get install -y git python2 python-setuptools

RUN pip install urllib2

# Add crontab file in the cron directory
ADD schedule /etc/cron.d/schedule
ADD . /root/repo

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/schedule

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log

RUN mkdir /root/.ssh
