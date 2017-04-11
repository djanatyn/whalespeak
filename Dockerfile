FROM ruby:2.2

WORKDIR /usr/src/app/

COPY . /usr/src/app/
RUN bundle install

CMD ["rackup", "-p", "80", "-o", "0.0.0.0"]
