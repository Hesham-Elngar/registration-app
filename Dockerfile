FROM tomcat:11.0-jdk21-openjdk-bookworm

# Create a non-root user for security
RUN useradd -m -u 1001 tomcat_user && \
    chown -R tomcat_user:tomcat_user /usr/local/tomcat

# Copy the WAR file(s) with proper ownership
COPY --chown=tomcat_user:tomcat_user ./*.war /usr/local/tomcat/webapps/

# Switch to non-root user
USER tomcat_user

# Expose the port Tomcat runs on
EXPOSE 8080
