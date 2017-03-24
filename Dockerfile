# From ruby 2.4 image based on debian
From ruby:2.4 

# skip installing gem documentation
RUN mkdir -p /usr/local/etc \
	&& { \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /usr/local/etc/gemrc

# Install apt dependencies
RUN apt-get update && apt-get install -y build-essential nodejs 

# Create a directory to hold application repository
ENV APP_HOME /dockerizing-rails5
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
 
# Copy gemfiles and lock gems
COPY Gemfile Gemfile.lock $APP_HOME/

# Install all gems 
RUN gem install bundler && bundle install --jobs 5 --retry 5

# Copy the main application
COPY . $APP_HOME 

# Expose port 3000
EXPOSE 3000

# Run rails server when container starts
CMD ["bundle exec rails s -b 0.0.0.0"]
