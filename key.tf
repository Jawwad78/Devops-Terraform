# Using locally generated SSH key (created with ssh-keygen) 
# Private key is stored in ~/.ssh/my-key
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"                      
  public_key = file("~/.ssh/id_rsa.pub")     
}