import subprocess
import datetime

# Target to scan (public test server - safe for scanning)
TARGET = "scanme.nmap.org"

def run_scan():
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M")
    output_file = f"results/scan_{timestamp}.txt"
    
    print(f"[+] Running Nmap scan on {TARGET}")
    
    result = subprocess.getoutput(f"nmap -sV -T4 {TARGET}")
    
    with open(output_file, "w") as f:
        f.write(result)

    print(f"[+] Scan complete! Saved to {output_file}")

if __name__ == "__main__":
    run_scan()