# Use the official n8n image as base
FROM n8nio/n8n:latest

# Switch to root to install additional packages
USER root

# Copy uv binary from the official image
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Make sure uv is executable
RUN chmod +x /usr/local/bin/uv

# Create symlink for uvx
RUN ln -s /usr/local/bin/uv /usr/local/bin/uvx

# Install mcp-atlassian globally
RUN uvx install mcp-atlassian

# Verify installations
RUN uv --version && \
    which uvx && \
    uvx --version

# Switch back to node user (best practice for security)
USER node

# Verify the node user can access the commands
RUN uvx --version && \
    uvx mcp-atlassian --help