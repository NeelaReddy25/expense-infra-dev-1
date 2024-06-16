resource "aws_key_pair" "vpn" {
    key_name = "vpn"
    #you can paste the public key directly like this
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCyGbMWjXv1zxYO8RRVHE/lMlmMuO/8ms9bMtg7w/fHYW6RIm2N0YNJE37YdMGtcXgc5BQYWjNIyoieqJq9I2V1OMyJRZnH+0Rw2bIvQs35QQqrK8gi31yoNYJVfHCUMiFImcLr4ozWxGFWv/DPZiCZlNEWS/E8C8rqmkYZdIWuReDvrQTZYJEikK46mEK9RsbDDTCoWWwMR4R741TmZWnuytH4gydRKFcuwvxwVFzC/I6JrWCfVtSZZwS2+eyxkek6KUE9Adw/PlNqhe7kGdDkZqBJ1XcuL2d/csbPKvARE+XwBGFPTM6aZ/Zti43xq73BLSdU7QNcGq8PsgNX5n8dleRjdKyGCY0n6W3TcHYo3IqJy4fJYJLvAVeh7YU/k3vvyAPfY1rSBmrCFV8nfzY7cifI+kZjJhZTIBQPBieQiK/GQcjnjpJdEZI0N600wvV609jQzhdAGwkWa2clx7D8lcystRGBg1VyuEPCy+iONVXAg//68c0CCSa2fdss/HIK+wMIhb1nscu0HveJ+4QBlCba3ktAQqrIkkavdW+mD5wxApfajdJVdHIgOsg/3+z41JX6+rzm4HY8dc+qUjNKQ6ZoaQF1DPe+uCVxXJyxY1iRun0zCJFEBhWzeJfhjmYte53ftfmjM9k3HUK2nwUj59jDSWvfoLePpa0i4UgC/Q== Neela Reddy@neela"
    #public_key = file("~/coursedevops.pub")
    # ~ means windows home directory
}


module "vpn" {
    source = "terraform-aws-modules/ec2-instance/aws"

    key_name = aws_key_pair.vpn.key_name
    name = "${var.project_name}-${var.environment}-vpn"

    instance_type = "t3.micro"
    vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
    #convert StringList to list and get first element 
    subnet_id = local.public_subnet_id
    ami = data.aws_ami.ami_info.id
    tags = merge (
        var.common_tags,
        {
            Name = "${var.project_name}-${var.environment}-vpn"
        }
    )
}