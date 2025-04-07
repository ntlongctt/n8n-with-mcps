# Use the official n8n image as base
FROM n8nio/n8n:latest

# Switch to root to install additional packages
USER root

# Copy uv binary from the official image
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv
RUN echo "=== STEP 1: UV COPY COMPLETED ==="

# Make sure uv is executable
RUN echo "=== CHECKING UV FILE ===" && \
    ls -la /usr/local/bin/uv && \
    echo "=== UV FILE CHECK COMPLETED ==="

RUN echo "=== MAKING UV EXECUTABLE ===" && \
    chmod +x /usr/local/bin/uv && \
    echo "=== UV NOW EXECUTABLE ==="

# Create symlink for uvx
RUN echo "=== CREATING UVX SYMLINK ===" && \
    ln -s /usr/local/bin/uv /usr/local/bin/uvx && \
    echo "=== UVX SYMLINK CREATED ==="

# Debug: Check if uv exists and is executable
RUN echo "=== CHECKING UV INSTALLATION ===" && \
    echo "File listing:" && \
    ls -la /usr/local/bin/uv && \
    echo "\nWhich UV:" && \
    which uv && \
    echo "\nUV Version:" && \
    /usr/local/bin/uv --version && \
    echo "=== UV CHECK COMPLETED ==="

# # Install Python and mcp-atlassian globally using Alpine's package manager
# RUN echo "=== INSTALLING PYTHON ===" && \
#     apk add --no-cache python3 py3-pip && \
#     echo "=== PYTHON INSTALLATION COMPLETED ==="

# # Install mcp-atlassian
# RUN echo "=== INSTALLING MCP-ATLASSIAN ===" && \
#     pip install mcp-atlassian && \
#     echo "=== MCP-ATLASSIAN INSTALLATION COMPLETED ==="

# Switch back to node user (best practice for security)
USER node
RUN echo "=== SWITCHED TO NODE USER ==="
# Verify the node user can access the commands