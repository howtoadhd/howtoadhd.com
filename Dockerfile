FROM howtoadhd/base-images:latest-app-builder

# Copy source files and set permissions
COPY . /app

# Install dependencies
RUN composer install \
        --no-ansi \
        --no-dev \
        --no-interaction \
        --no-progress

# Set permissions
RUN chmod +x bin/fix-permissions \
    && ./bin/fix-permissions
