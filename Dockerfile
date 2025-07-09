FROM ruby:latest
#ENTRYPOINT ["top", "-b"]
LABEL authors="E_Esmaeili"
WORKDIR /usr/src/app
RUN gem install bundler -v 2.4.10
RUN curl https://cli-assets.heroku.com/install.sh | sh
COPY . .
RUN bundle install
EXPOSE 5006
CMD heroku local:start
