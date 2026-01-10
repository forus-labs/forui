#!/usr/bin/env python3
"""Simple HTTP server with JSON file listing API for the JSON viewer."""

import http.server
import json
import os
from pathlib import Path

PORT = 8000
PROTOTYPE_DIR = Path(__file__).parent
SAMPLES_DIR = PROTOTYPE_DIR / ".." / "output"


class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(PROTOTYPE_DIR), **kwargs)

    def do_GET(self):
        if self.path == "/api/files":
            self.send_file_list()
        elif self.path.startswith("/samples/"):
            self.serve_sample_file()
        else:
            super().do_GET()

    def serve_sample_file(self):
        # Serve files from ../docs_snippets/output
        rel_path = self.path[len("/samples/"):]  # Remove /samples/ prefix
        file_path = SAMPLES_DIR / rel_path

        if not file_path.exists() or not file_path.is_file():
            self.send_error(404, "File not found")
            return

        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(file_path.read_bytes())

    def send_file_list(self):
        files = []
        if SAMPLES_DIR.exists():
            for json_file in sorted(SAMPLES_DIR.rglob("*.json")):
                rel_path = json_file.relative_to(SAMPLES_DIR)
                files.append(str(rel_path))

        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.end_headers()
        self.wfile.write(json.dumps(files).encode())


if __name__ == "__main__":
    print(f"Serving at http://localhost:{PORT}")
    print(f"Open http://localhost:{PORT}/json_viewer.html")
    with http.server.HTTPServer(("", PORT), Handler) as httpd:
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nShutting down...")
