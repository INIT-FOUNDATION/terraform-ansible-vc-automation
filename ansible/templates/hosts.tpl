[vc_hosts]
%{ for vc_server in vc_servers ~}
${vc_server.instance_id} vc_domain=${vc_server.domain}
%{ endfor ~}
