FROM ruby:3.0.6
RUN apt-get update -qq && apt-get install -y default-mysql-client sqlite3 build-essential libsqlite3-dev
RUN apt-get install -y curl
RUN apt-get remove -y yarn cmdtest

WORKDIR /myapp

# install nodejs(LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs
# RUN apt-get install -y yarn
#RUN yarn add @babel/plugin-proposal-private-property-in-object
#RUN yarn add @babel/plugin-proposal-private-methods

# install yarn
RUN npm install --global yarn
RUN yarn add @popperjs/core
RUN npx update-browserslist-db@latest
# Set NODE_OPTIONS environment variable

# Compile webpacker assets
ENV NODE_OPTIONS=--openssl-legacy-provider

# gem
COPY Gemfile* /myapp/
RUN bundle install
RUN rails webpacker:install
RUN rails webpacker:compile
RUN rails active_storage:install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]