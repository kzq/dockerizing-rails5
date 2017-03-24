# From ruby 2.4 image based on debian
From Ruby:2.4 

# Install apt dependencies
RUN apt-get update && apt-get install -y build-essential nodejs 

# Create a directory to hold application repository
RUN mkdir -p /app
WORKDIR /app
 
# Copy gemfiles and lock gems
COPY Gemfile Gemfile.lock ./

# Install all gems 
RUN gem install bundler && bundle install --jobs 5 --retry 5

# 


