import socket

targets = ["scanme.nmap.org", "google.com"]

print("Day 1 Recon Script\n--------------------")
for t in targets:
    try:
        ip = socket.gethostbyname(t)
        print(f"{t} --> {ip}")
    except:
        print(f"Failed to resolve {t}")