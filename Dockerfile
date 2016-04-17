FROM phusion/passenger-ruby22
MAINTAINER mm@idyll.io
#RUN rm -f /etc/service/nginx/down
#COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80

RUN apt-get update
RUN apt-get update --fix-missing
RUN apt-get install -y build-essential
RUN apt-get install -y nodejs
RUN apt-get install -y imagemagick
RUN apt-get install -y postgresql-contrib

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN gem install --no-rdoc --no-ri bundler
RUN npm install -g bower

# Install Rails App
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development test
RUN gem install foreman
COPY Procfile /app/Procfile

ADD . /app
WORKDIR /app
RUN bower install --allow-root
RUN bundle install --without development test
RUN mkdir /app/tmp && mkdir /app/tmp/cache/

# Add default foreman config
CMD bundle exec bundle exec rake assets:precompile && foreman start -f Procfile

# RUN bundle install
# CMD ["bundle exec rake assets:precompile && foreman start -f Procfile"]
# CMD ["/sbin/my_init", "--enable-insecure-key"]
