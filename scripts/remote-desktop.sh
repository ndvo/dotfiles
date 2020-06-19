$remoteIp="$1"
xfreerdp /v:$remoteIp  +glyph-cache  /relax-order-checks /size:800x600 /cert-ignore 
