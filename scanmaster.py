#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
ScanMaster - A Cross-Platform CLI Network Utility
Author: [Ghost-Rid3r]
"""

import argparse
import socket
import sys

def check_port(target_ip, port):
    """Attempt to connect to a specific port."""
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(1)
        result = sock.connect_ex((target_ip, port))
        sock.close()
        if result == 0:
            return True
        return False
    except socket.gaierror:
        print(f"[-] Error: Hostname '{target_ip}' could not be resolved.")
        sys.exit(1)
    except Exception as e:
        # Catch all other errors gracefully
        return False

def run_port_scan(args):
    """Scans a range of common ports on a target."""
    target_ip = args.target
    ports_to_scan = [21, 22, 23, 25, 53, 80, 110, 135, 139, 443, 445, 3389, 8080]
    
    print(f"\n[+] Starting ScanMaster on: {target_ip}...")
    print("---------------------------------------")
    
    for port in ports_to_scan:
        if check_port(target_ip, port):
            try:
                service_name = socket.getservbyport(port)
                print(f"[OPEN] Port {port:5}/TCP : {service_name}")
            except OSError:
                print(f"[OPEN] Port {port:5}/TCP : Unknown Service")
        else:
            if args.verbose:
                print(f"[CLOSED] Port {port:5}/TCP")
                
    print("---------------------------------------")
    print("[+] Scan Finished.")

def main():
    """Main function to handle CLI arguments."""
    parser = argparse.ArgumentParser(
        description='ScanMaster: Cross-Platform Security Tool by [Ghost-Rid3r]',
        usage='''scanmaster.py <command> [<args>]

Available commands:
   scan    Perform a quick port scan on common ports.
'''
    )
    
    # Subparsers for commands
    subparsers = parser.add_subparsers(dest='command', help='sub-command help')

    # --- 'scan' command ---
    scan_parser = subparsers.add_parser('scan', help='Run a quick port scan.')
    scan_parser.add_argument('target', type=str, help='The target IP address or hostname.')
    scan_parser.add_argument('-v', '--verbose', action='store_true', help='Show closed ports.')
    scan_parser.set_defaults(func=run_port_scan)

    # If no command is given, print help
    if len(sys.argv) == 1:
        parser.print_help(sys.stderr)
        sys.exit(1)
        
    args = parser.parse_args()
    
    # Execute the command function
    if hasattr(args, 'func'):
        args.func(args)
    else:
        parser.print_help(sys.stderr)

if __name__ == '__main__':
    main()