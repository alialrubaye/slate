# First stage
FROM xxxxxxxxxxx.dkr.ecr.us-east-2.amazonaws.com/slatedocs/slate:latest as builder

CMD cd /srv/slate

RUN bundle exec middleman build

# Second stage
FROM nginx:alpine

COPY --from=builder /srv/slate/build/index.html /usr/share/nginx/html/index.html
COPY --from=builder /srv/slate/build/fonts/* /usr/share/nginx/html/fonts/
COPY --from=builder /srv/slate/build/images/* /usr/share/nginx/html/images/
COPY --from=builder /srv/slate/build/javascripts/* /usr/share/nginx/html/javascripts/
COPY --from=builder /srv/slate/build/stylesheets/* /usr/share/nginx/html/stylesheets/

EXPOSE 80
