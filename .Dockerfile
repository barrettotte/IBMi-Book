FROM node:alpine

RUN apk update && apk upgrade && apk add --no-cache bash git openssh && rm -rf /var/cache/apk/*
RUN npm install -g gitbook-cli
RUN mkdir /gitbook

WORKDIR /gitbook
RUN git clone https://github.com/barrettotte/IBMi-Git-Book
WORKDIR IBMi-Git-Book
RUN gitbook install

EXPOSE 4000

CMD ["gitbook", "serve", "--timing"]

# docker run -d -p 4000:4000