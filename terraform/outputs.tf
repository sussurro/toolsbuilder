output "tools_ip" { value =  try(aws_instance.tools.public_ip,null) }
#output "tools_password" {     value = rsadecrypt(aws_instance.tools.password_data, file(var.key_path)) }




resource "local_file" "tools_inv" {
 content = templatefile("./inventory.tmpl",
 {
  cat = "tools",
  ip_addrs = [aws_instance.tools.public_ip]
  vars = ["ansible_connection: winrm",
	"ansible_user: Administrator",
	"ansible_winrm_scheme: http",
        "ansible_winrm_transport: basic",
        "ansible_winrm_server_cert_validation: ignore",
        "ansible_winrm_port: 5985",
        "ansible_password: ${var.dc_password}"
        ]
 }
 )
 filename = "../ansible/inventory/tools.yml"
}
