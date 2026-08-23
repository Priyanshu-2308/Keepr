FROM php:8.2-apache

# Copy all project files into Apache's web root
COPY . /var/www/html/

# Make sure PHP can write to data.json (session data + user/item storage)
RUN chown -R www-data:www-data /var/www/html \
    && chmod 664 /var/www/html/data.json

# Render sets $PORT at runtime; Apache defaults to 80, so we rewrite the listen port
RUN sed -i 's/80/${PORT}/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

EXPOSE 80

CMD ["apache2-foreground"]
