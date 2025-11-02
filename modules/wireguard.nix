{ pkgs, ... }: {
#   networking.wg-quick.interfaces =  {
#     wg0 = {
#       # IP address of this machine in the *tunnel network*
#       address = [
#         "172.16.65.3/32"
#         ];
#       dns = [
#         "172.16.64.1"
#       ];

#       # To match firewall allowedUDPPorts (without this wg
#       # uses random port numbers).
#       listenPort = 51820;

#       # Path to the private key file.
#       privateKeyFile = "/etc/wpiwa-vpn.key";

#       peers = [{
#         publicKey = "bknM1G/RS2yutcWn1r4mtdM7ZVAlgPpnJWJemnh+XHA=";
#         allowedIPs = [ "0.0.0.0/0,::/0" ];
#         endpoint = "130.215.55.168:51820";
#         persistentKeepalive = 25;
#       }];
#     };
#     wg1 = {
#       # IP address of this machine in the *tunnel network*
#       address = [
#         "172.16.5.5/32"
#         ];
#       dns = [
#         "172.16.0.1"
#       ];

#       # To match firewall allowedUDPPorts (without this wg
#       # uses random port numbers).
#       listenPort = 51820;

#       # Path to the private key file.
#       privateKeyFile = "/etc/wpiwa-wg1-vpn.key";

#       peers = [{
#         publicKey = "QqWdebXVZGQNeTqRMUZCdRUgN0eQEEFBoMtOBWC/GCg=";
#         allowedIPs = [ "0.0.0.0/0,::/0" ];
#         endpoint = "130.215.55.168:51820";
#         persistentKeepalive = 25;
#       }];
#     };
#   };
}
