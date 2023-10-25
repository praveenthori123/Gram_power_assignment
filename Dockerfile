FROM httpd:2.4

COPY ./dist/my-app /usr/local/apache2/htdocs

EXPOSE 80

CMD ["httpd-foreground"]
