# コピペでOK, /appもそのままでOK
FROM ruby:2.6.5

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

# 作業ディレクトリの作成、設定
RUN mkdir /app
# 作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /app
WORKDIR $APP_ROOT

# ホストPCのGemfileをコンテナにコピー
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT

# puma.sockを置くディレクトリを作成
RUN mkdir -p tmp/sockets

# 以下の記述があることでnginxから見ることができる
VOLUME $APP_ROOT/public
VOLUME $APP_ROOT/tmp

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec puma -C config/puma.rb"