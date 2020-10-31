;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	ns.rafael-backx.sb.uclllabs.be. root.localhost (
			      6		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	ns.rafael-backx.sb.uclllabs.be.
ns      IN      A       193.191.177.197
www     IN      A       193.191.177.197
test.rafael-backx.sb.uclllabs.be.    IN    A    193.191.177.254    
