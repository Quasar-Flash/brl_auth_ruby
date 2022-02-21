FROM ruby:3.1-slim-bullseye

WORKDIR /src

COPY brl_auth.gemspec /src/brl_auth.gemspec

COPY Gemfile /src/Gemfile

COPY . /src

RUN echo 'alias rspec="bundle exec rspec"' >> ~/.bashrc

RUN echo 'alias rubocop="bundle exec rubocop"' >> ~/.bashrc

RUN echo 'alias install="rake install"' >> ~/.bashrc

RUN echo 'alias build="rake build"' >> ~/.bashrc

RUN gem install bundler

RUN bundle install --jobs 2 --full-index

RUN rake install

CMD ["bash"]
