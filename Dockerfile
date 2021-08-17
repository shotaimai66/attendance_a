
# コピペでOK
FROM ruby:2.6.5

# railsのコンテナに必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

# 作業ディレクトリを作成します
RUN mkdir /app
##作業ディレクトリ名を変数に入れて、以降変数を利用します
ENV APP_ROOT /app
WORKDIR $APP_ROOT

# ホスト側のファイルをコンテナ側にコピーします
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# コンテナ内でbundle install
RUN bundle install
ADD . $APP_ROOT

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec puma -C config/puma.rb"